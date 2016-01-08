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
  end

  def show
    render template: current_page
  end

  def invalid_page
    raise ActionController::RoutingError, "No such page: #{params[:id]}"
  end

  private

  def current_page
    page_finder.find
  end

  def page_finder
    page_finder_factory.new(params[:id])
  end

  def page_finder_factory
    HighVoltage::PageFinder
  end
end
