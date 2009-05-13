class PagesController < ApplicationController
  # skip_before_filter :verify_account, :authenticate, :verify_access, :protect_page, :verify_can_use_ssl
  unloadable
  before_filter :ensure_valid

  def show
    render :template => current_page
  end

  protected

  def ensure_valid
    unless template_exists?(current_page)
      render :nothing => true, :status => 404 and return false
    end
  end

  def current_page
    "pages/#{params[:id].to_s.downcase}"
  end

  def template_exists?(path)
    view_paths.find_template(path, response.template.template_format)
  rescue ActionView::MissingTemplate
    false
  end
end
