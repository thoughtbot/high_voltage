require 'spec_helper'

describe HighVoltage::PagesController, 'action_caching' do
  it 'caches the action when action_caching is set to true', enable_caching: true do
    HighVoltage.action_caching = true

    load('high_voltage/pages_controller.rb')
    get :show, id: 'exists'

    action_was_cached(:exists).should be_true
  end

  it 'does not cache the action when action_caching is set to false', enable_caching: true do
    HighVoltage.action_caching = false

    load('high_voltage/pages_controller.rb')
    get :show, id: 'exists'

    action_was_cached(:exists).should be_false
  end

  def action_was_cached(page)
    ActionController::Base.cache_store.exist?("views/test.host#{page_path(page)}")
  end
end

