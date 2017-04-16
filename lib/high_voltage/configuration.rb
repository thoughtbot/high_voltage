module HighVoltage
  module Configuration
    attr_accessor(
      :content_path,
      :home_page,
      :parent_engine,
      :route_drawer,
      :routes,
      :parent_controller
    )

    def configure
      yield self
    end

    def self.extended(base)
      base.set_default_configuration
    end

    def page_ids
      HighVoltage::PageCollector.new(HighVoltage.full_path).page_ids
    end

    def full_path
      Rails.root.join("app", "views", HighVoltage.content_path)
    end

    def set_default_configuration
      self.content_path = 'pages/'
      self.home_page = nil
      self.route_drawer = HighVoltage::RouteDrawers::Default
      self.routes = true
      self.parent_controller = 'AppliationController'
    end
  end
end
