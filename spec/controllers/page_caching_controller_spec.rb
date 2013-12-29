require 'spec_helper'

describe HighVoltage::PagesController, '#cache_page' do
  let(:page_name) { :exists }

  context 'page_caching set to true' do
    it 'caches the page', enable_caching: true do
      HighVoltage.page_caching = true
      concern_reload

      controller.should_receive(:cache_page).at_least(:once)

      get :show, id: page_name
    end
  end

  context 'page_caching set to false' do
    it 'does not cache the page', enable_caching: true do
      HighVoltage.page_caching = false
      concern_reload

      controller.should_receive(:cache_page).never

      get :show, id: page_name
    end
  end
end

