require "chronic"

module Inputomatic
  class DateTime < ActiveRecord::Type::Value
    def initialize(*args, format: :long_ordinal, **kwargs)
      super *args, **kwargs
      @format = format
    end

    def cast_value(value)
      value.is_a?(String) ? Chronic.parse(value) : value
    end
  end
end