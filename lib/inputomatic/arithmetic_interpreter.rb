module Inputomatic
  class ArithmeticInterpreter
    CURRENCY_SYMBOLS = "$£¢€¥₩₪₹₫₴₱₲₳₵₸₺₼₽៛₠₡₢₣₤₥₦₧₨₩₪₫€₭₮₯₰₱₲₳₴₵₶₷₸₹₺₻₼₽₾₿ℳ".chars.freeze

    def initialize(input, decimal_separator: '.', thousands_separator: ',')
      @input = input
        .gsub(/\s+/, '')
        .gsub(thousands_separator, '')
        .gsub(Regexp.union(CURRENCY_SYMBOLS), '')
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
end