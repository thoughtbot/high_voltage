rails_versions = %w(
  6.1
  7.0
  7.1
  7.2
  8.0
)

rails_versions.each do |version|
  appraise "rails_#{version}" do
    gem "rails", "~> #{version}.0"
    gem "rails-controller-testing"
  end
end
