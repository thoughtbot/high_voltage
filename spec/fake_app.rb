class ApplicationController < ActionController::Base
  protect_from_forgery
end

# Create a rails app
module Dummy
  class Application < Rails::Application
    config.secret_key_base = "test"
    config.paths["public"] = ["spec/fixtures/public"]
    config.paths["config/routes.rb"] = ["spec/fixtures/config/routes.rb"]
    config.paths["app/views"] = ["spec/fixtures/app/views"]
    config.paths["app/controllers"] = ["spec/support/app/controllers"]
    config.eager_load = false
    config.action_controller.perform_caching = true
    config.action_controller.cache_store = :memory_store
  end
end
Dummy::Application.initialize!
