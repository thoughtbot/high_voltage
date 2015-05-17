require 'minimal_spec_helper'

describe HighVoltage::Configuration do
  describe 'basic config assignment' do
    let(:config_value) { 'fake_config_value' }

    before(:each) do
      HighVoltage.configure do |config|
        ActiveSupport::Deprecation.silence do
          config.action_caching = config_value
          config.action_caching_layout = config_value
          config.content_path = config_value
          config.layout = config_value
          config.page_caching = config_value
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

    it { expect(HighVoltage.action_caching).to eq config_value }
    it { expect(HighVoltage.action_caching_layout).to eq config_value }
    it { expect(HighVoltage.content_path).to eq config_value }
    it { expect(HighVoltage.layout).to eq config_value }
    it { expect(HighVoltage.page_caching).to eq config_value }
    it { expect(HighVoltage.parent_engine).to eq config_value }
    it { expect(HighVoltage.route_drawer).to eq config_value }
    it { expect(HighVoltage.routes).to eq config_value }
  end

  describe '#action_caching=true' do
    it 'displays a deprecation warning' do
      allow(ActiveSupport::Deprecation).to receive(:warn)

      HighVoltage.configure do |config|
        config.action_caching = true
      end

      expect(ActiveSupport::Deprecation).to have_received(:warn)
        .with(HighVoltage::Configuration::CACHING_DEPRECATION_WARNING)
    end
  end

  describe '#action_caching=false' do
    it 'does not display a deprecation warning' do
      allow(ActiveSupport::Deprecation).to receive(:warn)

      HighVoltage.configure do |config|
        config.action_caching = false
      end

      expect(ActiveSupport::Deprecation).not_to have_received(:warn)
                                                .with(HighVoltage::Configuration::CACHING_DEPRECATION_WARNING)
    end
  end

  describe '#action_caching_layout=true' do
    it 'displays a deprecation warning' do
      allow(ActiveSupport::Deprecation).to receive(:warn)

      HighVoltage.configure do |config|
        config.action_caching_layout = true
      end

      expect(ActiveSupport::Deprecation).to have_received(:warn)
        .with(HighVoltage::Configuration::CACHING_DEPRECATION_WARNING)
    end
  end

  describe '#action_caching_layout=false' do
    it 'does not display a deprecation warning' do
      allow(ActiveSupport::Deprecation).to receive(:warn)

      HighVoltage.configure do |config|
        config.action_caching_layout = false
      end

      expect(ActiveSupport::Deprecation).not_to have_received(:warn)
                                                .with(HighVoltage::Configuration::CACHING_DEPRECATION_WARNING)
    end
  end

  describe '#page_caching=true' do
    it 'displays a deprecation warning' do
      allow(ActiveSupport::Deprecation).to receive(:warn)

      HighVoltage.configure do |config|
        config.page_caching = true
      end

      expect(ActiveSupport::Deprecation).to have_received(:warn)
        .with(HighVoltage::Configuration::CACHING_DEPRECATION_WARNING)
    end
  end

  describe '#set_default_configuration' do
    it 'defaults caching without a deprecation warning' do
      allow(ActiveSupport::Deprecation).to receive(:warn)

      Class.new do
        extend HighVoltage::Configuration
      end

      expect(ActiveSupport::Deprecation).not_to have_received(:warn)
    end
  end
end
