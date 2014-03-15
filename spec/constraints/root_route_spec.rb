require 'spec_helper'

describe HighVoltage::Constraints::RootRoute, '.matches?' do
  it 'returns true when the view file exists' do
    request = double(path: 'index')
    Dir.stub(:glob).and_return(['about.html.erb'])

    result = HighVoltage::Constraints::RootRoute.matches?(request)

    expect(result).to be_true
  end

  it 'returns false when the view files does not exist' do
    request = double(path: 'index')
    File.stub(:glob).and_return([])

    result = HighVoltage::Constraints::RootRoute.matches?(request)

    expect(result).to be_false
  end
end
