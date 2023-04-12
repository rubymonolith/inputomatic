# frozen_string_literal: true

require_relative "inputomatic/version"

module Inputomatic
  class Error < StandardError; end

  autoload :ArithmeticInterpreter,  "inputomatic/arithmetic_interpreter"
  autoload :DateTime,               "inputomatic/date_time"
  autoload :Number,                 "inputomatic/number"
end
