class HighVoltage::PagesController < ApplicationController

  unloadable
  layout HighVoltage::layout

  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template #{HighVoltage::content_path}}
      raise ActionController::RoutingError, "No such page: #{params[:id]}"
    else
      raise exception
    end
  end

  def show
    render :template => current_page, :layout => HighVoltage::layout
  end

  protected

    def current_page
      "#{HighVoltage::content_path}#{clean_path}"
    end

    def clean_path
      path = Pathname.new "/#{params[:id]}"
      path.cleanpath.to_s[1..-1]
    end

end
