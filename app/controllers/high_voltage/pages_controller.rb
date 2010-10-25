class HighVoltage::PagesController < ApplicationController

  unloadable

  rescue_from ActionView::MissingTemplate, :with => :invalid_page

  def show
    render :template => current_page
  end

  protected

    def invalid_page
      raise ActionController::RoutingError, "No such page: #{params[:id]}"
    end

    def current_page
      "pages/#{params[:id].to_s.downcase}"
    end

end
