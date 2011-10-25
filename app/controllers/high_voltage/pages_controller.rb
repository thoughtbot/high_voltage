class HighVoltage::PagesController < ApplicationController

  unloadable
  layout Proc.new { |_| HighVoltage.layout }

  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template #{content_path}}
      begin
        render :template => "#{current_page}/index", :layout => layout
      rescue ActionView::MissingTemplate => e
        raise ActionController::RoutingError, "No such page: #{params[:id]}"
      end
    else
      raise exception
    end
  end

  def show
    render :template => current_page
  end

  protected

    def current_page
      "#{content_path}#{clean_path}"
    end

    def clean_path
      path = Pathname.new "/#{params[:id]}"
      path.cleanpath.to_s[1..-1]
    end

    def content_path
      HighVoltage.content_path
    end

end
