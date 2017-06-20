rails_versions = ['~> 4.0.0', '~> 4.1.0', '~> 4.2.0']

rails_versions.each do |rails_version|
  appraise "rails#{rails_version.slice(/\d+\.\d+/)}" do
    gem 'rails', rails_version
  end
end

rails_5x_version = ['~> 5.0.0', '~> 5.1.0']
rails_5x_version.each do |rails_version|
  appraise "rails#{rails_version.slice(/\d+\.\d+/)}" do
    gem 'rails', rails_version
    gem "rails-controller-testing"
  end
end
