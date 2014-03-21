require 'spec_helper'

describe HighVoltage::PagesController, '#cache_page' do
  let(:page_name) { :exists }

  context 'page_caching set to true' do
    after do
      set_page_caching_without_deprecation(false)
    end

    it 'caches the page' do
      allow(controller).to receive(:cache_page)
      set_page_caching_without_deprecation(true)

      get :show, id: page_name

      expect(controller).to have_received(:cache_page)
    end
  end

  context 'page_caching set to false' do
    it 'does not cache the page' do
      allow(controller).to receive(:cache_page)
      set_page_caching_without_deprecation(false)

      get :show, id: page_name

      expect(controller).not_to have_received(:cache_page)
    end
  end

  def set_page_caching_without_deprecation(value)
    ActiveSupport::Deprecation.silence do
      HighVoltage.page_caching = value
    end
  end
end
