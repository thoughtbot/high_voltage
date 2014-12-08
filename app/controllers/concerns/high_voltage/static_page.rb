module HighVoltage::StaticPage
  extend ActiveSupport::Concern

  included do
    layout ->(_) { HighVoltage.layout }

    rescue_from ActionView::MissingTemplate do |exception|
      if exception.message =~ %r{Missing template #{page_finder.content_path}}
        invalid_page
      else
        raise exception
      end
    end

    rescue_from HighVoltage::InvalidPageIdError, with: :invalid_page

    if respond_to?(:caches_action)
      caches_action :show, layout: HighVoltage.action_caching_layout,
        if: -> { HighVoltage.action_caching }
    end

    if respond_to?(:caches_page)
      caches_page :show, if: -> { HighVoltage.page_caching }
    end

    hide_action :current_page, :page_finder, :page_finder_factory
  end

  def show
    render template: current_page
  end

  def current_page
    page_finder.find
  end

  def page_finder
    page_finder_factory.new(params[:id])
  end

  def page_finder_factory
    HighVoltage::PageFinder
  end

  def invalid_page
    raise ActionController::RoutingError, "No such page: #{params[:id]}"
  end
end
