module HighVoltage
  module Configuration
    CACHING_DEPRECATION_WARNING = <<-WARNING.strip_heredoc.squish
    Caching support has been deprecated and will be removed
    in the next release.
    WARNING

    attr_accessor(
      :content_path,
      :home_page,
      :layout,
      :route_drawer,
      :routes,
    )

    attr_reader :action_caching, :action_caching_layout, :page_caching

    def configure
      yield self
    end

    def self.extended(base)
      base.set_default_configuration
    end

    def action_caching=(value)
      ActiveSupport::Deprecation.warn(CACHING_DEPRECATION_WARNING)
      @action_caching = value
    end

    def action_caching_layout=(value)
      ActiveSupport::Deprecation.warn(CACHING_DEPRECATION_WARNING)
      @action_caching_layout = value
    end

    def page_caching=(value)
      ActiveSupport::Deprecation.warn(CACHING_DEPRECATION_WARNING)
      @page_caching = value
    end

    def set_default_configuration
      @action_caching = false
      @action_caching_layout = true
      @page_caching = false

      self.content_path = 'pages/'
      self.home_page = nil
      self.layout = 'application'
      self.route_drawer = HighVoltage::RouteDrawers::Default
      self.routes = true
    end
  end
end
