rails_versions = %w(
  5.0
  5.1
  5.2
  6.0
)

rails_versions.each do |version|
  appraise "rails_#{version}" do
    gem "rails", "~> #{version}.0"
    if Gem::Version.new(version) >= Gem::Version.new("5.0")
      gem "rails-controller-testing"
    end

    if Gem::Version.new(version) >= Gem::Version.new("6.0")
      # TODO - Switch to 4.0 gem once release is made
      gem 'rspec-rails', '~> 4.0.0.beta2'
    else
      gem 'rspec-rails', '~> 3.1'
    end
  end
end
