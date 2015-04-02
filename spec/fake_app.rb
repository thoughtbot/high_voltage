class ApplicationController < ActionController::Base
  protect_from_forgery
end

# Create a rails app
module Dummy
  class Application < Rails::Application
    config.secret_key_base = "test"
    config.eager_load = false
    config.action_controller.perform_caching = true
    config.action_controller.cache_store = :memory_store
    config.root = "spec/fixtures"
  end
end
Dummy::Application.initialize!
