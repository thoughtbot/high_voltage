require 'spec_helper'

describe HighVoltage::Constraints::RootRoute, '.matches?' do
  context 'view file exists' do
    it 'should return true' do
      request = double(path: 'index')
      Dir.stub(:glob).and_return(['about.html.erb'])

      result = HighVoltage::Constraints::RootRoute.matches?(request)

      expect(result).to be_true
    end
  end

  context 'view file does not exist' do
    it 'should return false' do
      request = double(path: 'index')
      File.stub(:glob).and_return([])

      result = HighVoltage::Constraints::RootRoute.matches?(request)

      expect(result).to be_false
    end
  end
end
