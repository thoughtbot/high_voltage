require 'spec_helper'

describe HighVoltage::PagesController, 'action_caching' do
  it 'caches the page when page_caching is set to true', enable_caching: true do
    controller.should_receive(:cache_page).at_least(:once)

    HighVoltage.page_caching = true
    concern_reload
    get :show, id: :exists
  end

  it 'does not cache the page when page_caching is set to false', enable_caching: true do
    controller.should_receive(:cache_page).never

    HighVoltage.page_caching = false
    concern_reload
    get :show, id: :exists
  end
end

