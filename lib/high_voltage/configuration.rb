module HighVoltage
  module Configuration
    attr_accessor(
      :content_path,
      :home_page,
      :layout,
      :parent_engine,
      :route_drawer,
      :routes,
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
      self.layout = 'application'
      self.route_drawer = HighVoltage::RouteDrawers::Default
      self.routes = true
    end
  end
end
