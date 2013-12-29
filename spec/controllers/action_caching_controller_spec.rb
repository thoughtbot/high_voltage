require 'spec_helper'

describe HighVoltage::PagesController, '#action_caching' do
  let(:page_name) { :exists }

  context 'action_caching set to true' do
    it 'caches the action', enable_caching: true do
      HighVoltage.action_caching = true
      concern_reload

      expect { get :show, id: page_name }.to change { action_cache_exists? }
    end
  end

  context 'action_caching set to false' do
    it 'does not cache the action', enable_caching: true do
      HighVoltage.action_caching = false
      concern_reload

      expect { get :show, id: page_name }.to_not change { action_cache_exists? }
    end
  end

  def action_cache_exists?
    ActionController::Base.cache_store.exist?("views/test.host#{page_path(page_name)}")
  end
end
