ENV['RAILS_ENV'] = 'test'

require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'action_controller'
require 'test_help'
require 'high_voltage'

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'app', 'controllers')
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'app', 'models')

require 'shoulda'
require 'shoulda/rails'

ActionController::Routing::Routes.draw do |map|
  HighVoltage::Routes.draw(map)
end
