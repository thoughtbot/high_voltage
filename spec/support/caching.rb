RSpec.configure do |config|
  config.around(:each, enable_caching: true) do |example|
    ActionController::Base.perform_caching = true
    old_cache_store = ActionController::Base.cache_store
    ActionController::Base.cache_store = :memory_store

    example.run

    ActionController::Base.cache_store = old_cache_store
    ActionController::Base.perform_caching = false
  end
end
