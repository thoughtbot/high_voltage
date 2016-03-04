ENV["RAILS_ENV"] = "test"

require "pry"
require "active_model/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "rspec/rails"

require "high_voltage"
require "fake_app"

Rails.backtrace_cleaner.remove_silencers!

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |file| require file }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.after(:each) do
    HighVoltage.set_default_configuration
    Rails.application.reload_routes!
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Matchers
  config.mock_with :rspec
  config.order = "random"

  if Rails::VERSION::MAJOR >= 5
    require "rails-controller-testing"

    config.include(
      Rails::Controller::Testing::TemplateAssertions,
      type: :controller,
    )
  end
end
