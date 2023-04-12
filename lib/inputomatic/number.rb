module Inputomatic
  class Number < ActiveRecord::Type::Value
    def cast_value(value)
      value.is_a?(String) ? ArithmeticInterpreter.new(value).parse : value
    end
  end
end