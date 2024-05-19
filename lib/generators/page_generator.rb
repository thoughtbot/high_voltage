class PageGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def add_page
    create_file "app/views/pages/#{file_name}.html.erb"
  end
end
