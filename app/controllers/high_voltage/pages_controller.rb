class HighVoltage::PagesController < ApplicationController
  unloadable
  layout Proc.new { |_| HighVoltage.layout }

  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template #{page_finder.content_path}}
      raise ActionController::RoutingError, "No such page: #{params[:id]}"
    else
      raise exception
    end
  end

  def show
    render :template => current_page
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
