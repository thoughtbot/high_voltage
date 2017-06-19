require "spec_helper"

describe HighVoltage::Constraints::RootRoute do
  describe "#matches?" do
    it "returns true when the view file exists" do
      request = double(path: "exists")

      result = described_class.new.matches?(request)

      expect(result).to be true
    end

    it "returns true when the view file exists and url ends with .html" do
      request = double(path: "exists.html")

      result = described_class.new.matches?(request)

      expect(result).to be true
    end

    it "returns false when the view files does not exist" do
      request = double(path: "index")

      result = described_class.new.matches?(request)

      expect(result).to be false
    end
  end
end
