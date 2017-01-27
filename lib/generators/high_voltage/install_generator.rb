require "rails"

module HighVoltage
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Creates a HighVoltage initializer"
      source_root File.expand_path("../templates", __FILE__)
      def copy_initializer
        copy_file "high_voltage.rb", "config/initializers/high_voltage.rb"
      end
    end
  end
end
