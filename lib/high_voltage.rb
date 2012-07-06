require 'high_voltage/version'

module HighVoltage
  mattr_accessor :layout
  @@layout = "application"

  mattr_accessor :content_path
  @@content_path = "pages/"

  mattr_accessor :fallback_to_index_pages
  @@fallback_to_index_pages = false

  def self.setup
    yield self
  end

  require 'high_voltage/engine' if defined?(Rails)
end
