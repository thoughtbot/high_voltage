require 'spec_helper'

describe HighVoltage::Configuration do
  let(:config_value) { 'fake_config_value' }

  before(:each) do
    HighVoltage.configure do |config|
      config.action_caching = config_value
      config.action_caching_layout = config_value
      config.content_path = config_value
      config.layout = config_value
      config.page_caching = config_value
      config.route_drawer = config_value
      config.routes = config_value
    end
  end

  it { expect(HighVoltage.action_caching).to eq config_value }
  it { expect(HighVoltage.action_caching_layout).to eq config_value }
  it { expect(HighVoltage.content_path).to eq config_value }
  it { expect(HighVoltage.layout).to eq config_value }
  it { expect(HighVoltage.page_caching).to eq config_value }
  it { expect(HighVoltage.route_drawer).to eq config_value }
  it { expect(HighVoltage.routes).to eq config_value }
end
