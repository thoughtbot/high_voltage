require 'spec_helper'

describe HighVoltage::PagesController, '#action_caching' do
  let(:page_name) { :exists }

  context 'action_caching set to true' do
    after do
      set_action_caching_without_deprecation(false)
    end

    it 'caches the action' do
      allow(controller).to receive(:_save_fragment)
      set_action_caching_without_deprecation(true)

      get :show, id: page_name

      expect(controller).to have_received(:_save_fragment)
        .with("test.host#{page_path(page_name)}", {})
    end
  end

  context 'action_caching set to false' do
    it 'does not cache the action' do
      allow(controller).to receive(:_save_fragment)
      set_action_caching_without_deprecation(false)

      get :show, id: page_name

      expect(controller).not_to have_received(:_save_fragment)
    end
  end

  def set_action_caching_without_deprecation(value)
    ActiveSupport::Deprecation.silence do
      HighVoltage.action_caching = value
    end
  end
end
