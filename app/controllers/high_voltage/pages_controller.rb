class HighVoltage::PagesController < ApplicationController
  layout Proc.new { |_| HighVoltage.layout }

  if respond_to?('caches_action')
    caches_action :show, if: Proc.new {
      HighVoltage.action_caching
    }
  end

  if respond_to?('caches_page')
    caches_page :show, if: Proc.new {
      HighVoltage.page_caching
    }
  end

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
