if defined?(ActionController::Routing::RouteSet)
  class ActionController::Routing::RouteSet
    def load_routes_with_high_voltage!
      lib_path = File.dirname(__FILE__)
      high_voltage_routes = File.join(lib_path, *%w[.. .. .. config high_voltage_routes.rb])
      unless configuration_files.include?(high_voltage_routes)
        add_configuration_file(high_voltage_routes)
      end
      load_routes_without_high_voltage!
    end

    alias_method_chain :load_routes!, :high_voltage
  end
end

