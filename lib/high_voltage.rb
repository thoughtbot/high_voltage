require 'high_voltage/version'

module HighVoltage
  mattr_accessor :layout
  @@layout = "application"

  mattr_accessor :content_path
  @@content_path = "pages/"

  mattr_accessor :no_routes
  @@no_routes = false

  def self.setup
    yield self
  end

  require 'high_voltage/engine' if defined?(Rails)
end
