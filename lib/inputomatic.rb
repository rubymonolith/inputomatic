# frozen_string_literal: true

require_relative "inputomatic/version"
require "chronic"

module Inputomatic
  class Error < StandardError; end

  class ArithmeticInterpreter
    def initialize(input, decimal_separator: '.', thousands_separator: ',')
      @input = input.gsub(/\s+/, '').gsub(thousands_separator, '')
      @decimal_separator = decimal_separator
      @index = 0
    end

    def parse
      result = expression
      if @index < @input.length
        raise "Unexpected character: #{@input[@index]}"
      end
      result
    end

    private

    def expression
      result = term
      while @index < @input.length
        case @input[@index]
        when '+'
          @index += 1
          result += term
        when '-'
          @index += 1
          result -= term
        else
          break
        end
      end
      result
    end

    def term
      result = factor
      while @index < @input.length
        case @input[@index]
        when '*'
          @index += 1
          result *= factor
        when '/'
          @index += 1
          result /= factor
        else
          break
        end
      end
      result
    end

    def factor
      if @input[@index] == '('
        @index += 1
        result = expression
        if @input[@index] != ')'
          raise "Expected ')'"
        end
        @index += 1
      else
        start_index = @index
        while @index < @input.length && /[\d#{@decimal_separator}]/.match?(@input[@index])
          @index += 1
        end
        result = @input[start_index...@index].gsub(@decimal_separator, '.').to_f
      end
      result
    end
  end

  class DateTime < ActiveRecord::Type::Value
    def initialize(*args, format: :long_ordinal, **kwargs)
      super *args, **kwargs
      @format = format
    end

    def cast_value(value)
      value.is_a?(String) ? Chronic.parse(value) : value
    end
  end

  class Number < ActiveRecord::Type::Value
    def cast_value(value)
      value.is_a?(String) ? ArithmeticInterpreter.new(value).parse : value
    end
  end
end
