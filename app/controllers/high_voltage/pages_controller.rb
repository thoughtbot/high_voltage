class HighVoltage::PagesController < ApplicationController
  VALID_CHARACTERS = "a-zA-Z0-9~!@$%^&*()#`_+-=<>\"{}|[];',?".freeze

  unloadable
  layout Proc.new { |_| HighVoltage.layout }

  rescue_from ActionView::MissingTemplate do |exception|
    if exception.message =~ %r{Missing template #{content_path}}
      if HighVoltage.fallback_to_index_pages
        begin
          render :template => "#{current_page}/index"
        rescue ActionView::MissingTemplate => e
          raise ActionController::RoutingError, "No such page: #{params[:id]}"
        end
      else
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
      path = Pathname.new("/#{clean_id}")
      path.cleanpath.to_s[1..-1]
    end

    def content_path
      HighVoltage.content_path
    end

    def clean_id
      params[:id].tr("^#{VALID_CHARACTERS}", '')
    end
end
