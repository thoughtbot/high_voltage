ENV['RAILS_ENV'] = 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rails/test_help'
require 'rspec/rails'
require 'capybara/rails'

Rails.backtrace_cleaner.remove_silencers!
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  require 'rspec/expectations'
  config.include RSpec::Matchers
  config.mock_with :rspec
end
