require 'spec_helper'

describe HighVoltage::Constraints::RootRoute, '.matches?' do
  context 'view file exists' do
    it 'should return true' do
      request = stub(:path => 'index')
      Dir.stub!(:glob).and_return(['about.html.erb'])

      HighVoltage::Constraints::RootRoute.matches?(request).should be_true
    end
  end

  context 'view file does not exist' do
    it 'should return false' do
      request = stub(:path => 'index')
      File.stub!(:glob).and_return([])

      HighVoltage::Constraints::RootRoute.matches?(request).should be_false
    end
  end
end
