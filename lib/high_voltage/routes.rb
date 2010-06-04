module HighVoltage
  class Routes
    # In your application's config/routes.rb, draw High Voltage's routes:
    #
    # @example
    #   HighVoltage::Routes.draw(map)
    #
    # If you need to override a High Voltage route, replace it with
    # your app route:
    #
    # @example
    #   map.resources :pages, :controller => :pages, :only => [:show]
    #   # HighVoltage::Routes.draw(map)
    def self.draw(map)
      map.resources :pages,
        :controller => 'high_voltage/pages',
        :only       => [:show]
    end
  end
end
