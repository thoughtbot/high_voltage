rails_versions = ['~> 4.2.0', '~> 5.0.0', '~> 5.1.0', '~> 5.2.0']
rails_versions.each do |rails_version|
  appraise "rails#{rails_version.slice(/\d+\.\d+/)}" do
    gem 'rails', rails_version
  end
end
