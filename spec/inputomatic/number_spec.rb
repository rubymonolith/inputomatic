require "spec_helper"

RSpec.describe Inputomatic::Number do
  let(:input) { described_class.new }
  let(:expression) { self.class.description }
  let(:cast) { input.cast(expression) }
  subject { cast }

  describe "1+1" do
    it { is_expected.to eql 2.0 }
  end

  describe " ((1,000 * 90   ) - 20     ) / 005.5             " do
    it { is_expected.to eql 16360.0 }
  end

  describe "$1,000.00" do
    it { is_expected.to eql 1000.0 }
  end

  describe "" do
    it { is_expected.to eql 0.0 }
  end
end
