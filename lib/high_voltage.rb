require 'high_voltage/version'
require 'high_voltage/constraints/root_route'
require 'high_voltage/page_finder'
require 'high_voltage/route_drawers/default'
require 'high_voltage/route_drawers/root'

module HighVoltage
  mattr_accessor :layout
  @@layout = 'application'

  mattr_accessor :content_path
  @@content_path = 'pages/'

  mattr_accessor :route_drawer
  @@route_drawer = HighVoltage::RouteDrawers::Default

  mattr_accessor :routes
  @@routes = true

  def self.setup
    yield self
  end

  require 'high_voltage/engine' if defined?(Rails)
end
