rails_versions = %w(
  5.2
  6.0
  6.1
  7.0
)

rails_versions.each do |version|
  appraise "rails_#{version}" do
    gem "rails", "~> #{version}.0"
    gem "rails-controller-testing"
    if Gem::Version.new(version) >= Gem::Version.new("6.1")
      gem 'rspec-rails', '~> 6.0.0'
    else
      gem 'rspec-rails', '~> 5.0.0'
    end
  end
end
