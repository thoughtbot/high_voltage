class HighVoltage::PagesController < ApplicationController
  caches_page *HighVoltage::caches_page
  unloadable

  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template pages/}
      raise ActionController::RoutingError, "No such page: #{params[:action]}"
    else
      raise exception
    end
  end

  def method_missing(name, *args, &block)
    render :template => current_page
  end

  protected

    def current_page
      "#{HighVoltage::content_path}#{clean_path}"
    end

    def clean_path
      path = Pathname.new "/#{params[:action]}"
      path.cleanpath.to_s[1..-1]
    end

end
