module HighVoltage
  module RouteDrawers
    # Matches routes in the HighVoltage.content_path directory. By default this looks
    # for /pages/id. e.g. http://www.example.com/pages/about_us
    class Default
      def self.match_attributes
        {
          "/#{HighVoltage.content_path}*id" => 'high_voltage/pages#show',
          :as => :page,
          :format => false
        }
      end
    end
  end
end
