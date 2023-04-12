require "spec_helper"

RSpec.describe Inputomatic::DateTime do
  let(:input) { described_class.new }
  let(:expression) { self.class.description }
  let(:cast) { input.cast(expression) }
  subject { cast }

  describe "Today at 9:00a" do
    it { is_expected.to eql Time.new(Time.now.year, Time.now.month, Time.now.day, 9, 0, 0).gmtime  }
  end

  describe "March 14, 3412" do
    it { is_expected.to eql Time.new(3412, 3, 14, 12, 0, 0).gmtime }
  end

  describe "2022-11-01T14:30:00" do
    it { is_expected.to eql Time.new(2022, 11, 1, 14, 30, 0).gmtime }
  end

  describe "2023-06-15 18:45:00" do
    it { is_expected.to eql Time.new(2023, 6, 15, 18, 45, 0).gmtime }
  end

  describe "dog" do
    it { is_expected.to be_nil }
  end
end
