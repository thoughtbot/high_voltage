class HighVoltage::PagesController < ApplicationController

  unloadable

  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template pages/}
      raise ActionController::RoutingError, "No such page: #{params[:id]}"
    else
      raise exception
    end
  end

  def show
    if params[:layout].nil?
      render current_page
    else
      render current_page, :layout=>params[:layout]
    end
  end

  protected

    def current_page
      "pages/#{clean_path}"
    end

    def clean_path
      path = Pathname.new "/#{params[:id]}"
      path.cleanpath.to_s[1..-1]
    end

end
