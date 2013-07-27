require 'spec_helper'

describe HighVoltage::PagesController, 'action_caching' do
  it 'caches the action when action_caching is set to true', enable_caching: true do
    expect do
      HighVoltage.action_caching = true
      concern_reload
      get :show, id: :exists
    end.to change { action_was_cached(:exists) }
  end

  it 'does not cache the action when action_caching is set to false', enable_caching: true do
    expect do
      HighVoltage.action_caching = false
      concern_reload
      get :show, id: :exists
    end.to_not change { action_was_cached(:exists) }
  end

  def action_was_cached(page)
    ActionController::Base.cache_store.exist?("views/test.host#{page_path(page)}")
  end
end
