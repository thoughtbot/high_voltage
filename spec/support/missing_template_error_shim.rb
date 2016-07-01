module MissingTemplateErrorShim
  def missing_template_error
    if Rails::VERSION::MAJOR >= 5
      ActionView::Template::Error
    else
      ActionView::MissingTemplate
    end
  end
end

RSpec.configure do |config|
  config.include MissingTemplateErrorShim, type: :controller
end
