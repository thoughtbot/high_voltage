require 'spec_helper'

describe HighVoltage::PagesController, '#cache_page' do
  let(:page_name) { :exists }

  context 'page_caching set to true' do
    after do
      HighVoltage.page_caching = false
    end

    it 'caches the page' do
      allow(controller).to receive(:cache_page)
      HighVoltage.page_caching = true

      get :show, id: page_name

      expect(controller).to have_received(:cache_page)
    end
  end

  context 'page_caching set to false' do
    it 'does not cache the page' do
      allow(controller).to receive(:cache_page)
      HighVoltage.page_caching = false

      get :show, id: page_name

      expect(controller).not_to have_received(:cache_page)
    end
  end
end
