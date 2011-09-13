module HighVoltage
  mattr_accessor :caches_page
  @@caches_page = nil

  mattr_accessor :layout
  @@layout = "application"

  mattr_accessor :content_path
  @@content_path = "pages/"

  def self.setup
    yield self
  end

  require 'high_voltage/engine' if defined?(Rails)
end
