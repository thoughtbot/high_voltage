rails_versions = ['~> 4.0.0', '~> 4.1.0', '~> 4.2.0']

rails_versions.each do |rails_version|
  appraise "rails#{rails_version.slice(/\d+\.\d+/)}" do
    gem 'rails', rails_version
  end
end

appraise "rails50" do
  gem "rails", "~> 5.0.0.beta3"
  gem "rspec-rails", "3.5.0.beta1"
  gem "rails-controller-testing"
end
