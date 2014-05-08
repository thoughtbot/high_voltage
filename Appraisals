if RUBY_VERSION >= '2.0'
  rails_versions = ['~> 3.2.13', '~> 4.0.0', '~> 4.1.0']
else
  rails_versions = ['~> 3.1.12', '~> 3.2.13']
end

rails_versions.each do |rails_version|
  appraise "rails#{rails_version.slice(/\d+\.\d+/)}" do
    gem 'rails', rails_version

    if ['~> 4.0.0', '~> 4.1.0'].include? rails_version
      gem 'actionpack-action_caching'
      gem 'actionpack-page_caching'
    end
  end
end
