require 'spec_helper'

describe HighVoltage::PagesController, '#action_caching' do
  let(:page_name) { :exists }

  context 'action_caching set to true' do
    after do
      HighVoltage.action_caching = false
    end

    it 'caches the action' do
      HighVoltage.action_caching = true
      allow(controller).to receive(:_save_fragment)

      get :show, id: page_name

      expect(controller).to have_received(:_save_fragment)
        .with("test.host#{page_path(page_name)}", {})
    end
  end

  context 'action_caching set to false' do
    it 'does not cache the action' do
      allow(controller).to receive(:_save_fragment)
      HighVoltage.action_caching = false

      get :show, id: page_name

      expect(controller).not_to have_received(:_save_fragment)
    end
  end
end
