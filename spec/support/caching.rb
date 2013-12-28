RSpec.configure do |config|
  config.around(:each, enable_caching: true) do |example|
    previous_cache_store = ActionController::Base.cache_store

    ActionController::Base.perform_caching = true
    ActionController::Base.cache_store = :memory_store
    ActionController::Base.cache_store.clear

    example.run

    ActionController::Base.cache_store.clear
    ActionController::Base.cache_store = previous_cache_store
    ActionController::Base.perform_caching = false
  end
end
