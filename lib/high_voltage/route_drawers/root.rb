module HighVoltage
  module RouteDrawers
    # Matches routes from root of the domain e.g. http://www.example.com/about_us
    # Uses HighVoltage::Constraints::RootRoute to validate view exists.
    class Root
      def self.match_attributes
        {
          "/*id" => 'high_voltage/pages#show',
          :as => :page,
          :format => false,
          :constraints => HighVoltage::Constraints::RootRoute
        }
      end
    end
  end
end
