ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)

require 'capybara/rails'
require 'pry'
require 'rails/test_help'
require 'rspec/expectations'
require 'rspec/rails'

Rails.backtrace_cleaner.remove_silencers!
Capybara.default_driver = :rack_test
Capybara.default_selector = :css

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.after(:each) do
    HighVoltage.set_default_configuration
    Rails.application.reload_routes!
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Matchers
  config.mock_with :rspec
  config.order = 'random'
end
