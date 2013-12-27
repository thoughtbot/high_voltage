module HighVoltage
  module Configuration
    attr_accessor(
      :action_caching,
      :action_caching_layout,
      :content_path,
      :home_page,
      :layout,
      :page_caching,
      :route_drawer,
      :routes,
    )

    def configure
      yield self
    end

    def self.extended(base)
      base.set_default_configuration
    end

    def set_default_configuration
      self.action_caching = false
      self.action_caching_layout = true
      self.content_path = 'pages/'
      self.home_page = nil
      self.layout = 'application'
      self.page_caching = false
      self.route_drawer = HighVoltage::RouteDrawers::Default
      self.routes = true
    end
  end
end
