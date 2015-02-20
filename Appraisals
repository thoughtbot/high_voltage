rails_versions = ['~> 4.0.0', '~> 4.1.0', '~> 4.2.0']

rails_versions.each do |rails_version|
  appraise "rails#{rails_version.slice(/\d+\.\d+/)}" do
    gem 'rails', rails_version
    gem 'actionpack-action_caching'
    gem 'actionpack-page_caching'
  end
end
