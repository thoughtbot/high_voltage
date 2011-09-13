HighVoltage.setup do |config|
  # List of pages that should be cached.
  config.caches_page = *[:test, :ladeedah]

  # Location of your static content
  config.content_path = 'pages/'

  # Layout that will be used to render your pages
  #config.layout = 'application'
end
