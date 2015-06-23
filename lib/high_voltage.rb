require 'active_support/core_ext/string'
require 'active_support/core_ext/module/attribute_accessors'

require 'high_voltage/configuration'
require 'high_voltage/constraints/root_route'
require "high_voltage/page"
require "high_voltage/page_collector"
require 'high_voltage/page_finder'
require 'high_voltage/route_drawers/default'
require 'high_voltage/route_drawers/root'
require 'high_voltage/version'

module HighVoltage
  extend Configuration
  require 'high_voltage/engine' if defined?(Rails)
end
