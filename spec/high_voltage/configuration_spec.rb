require 'minimal_spec_helper'

describe HighVoltage::Configuration do
  describe 'basic config assignment' do
    let(:config_value) { 'fake_config_value' }

    before(:each) do
      HighVoltage.configure do |config|
        ActiveSupport::Deprecation.silence do
          config.content_path = config_value
          config.layout = config_value
          config.parent_engine = config_value
          config.route_drawer = config_value
          config.routes = config_value
        end
      end
    end

    after(:each) do
      HighVoltage.configure do |config|
        config.parent_engine = Rails.application
      end
    end

    it { expect(HighVoltage.content_path).to eq config_value }
    it { expect(HighVoltage.layout).to eq config_value }
    it { expect(HighVoltage.parent_engine).to eq config_value }
    it { expect(HighVoltage.route_drawer).to eq config_value }
    it { expect(HighVoltage.routes).to eq config_value }
  end
end
