require 'spec_helper'

describe HighVoltage::Constraints::RootRoute, '.matches?' do
  let(:request) { stub(:path => 'index') }
  let(:matches) { HighVoltage::Constraints::RootRoute.matches?(request) }

  before do
    Dir.stub!(:glob).and_return(found_filenames)
  end

  subject { matches }

  context 'view file exists' do
    let(:found_filenames) { ['about.html.erb'] }
    it { should be_true }
  end

  context 'view file does not exist' do
    let(:found_filenames) { [] }
    it { should be_false }
  end
end
