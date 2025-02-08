rails_versions = %w(
  7.0
  7.1
  7.2
  8.0
)

rails_versions.each do |version|
  appraise "rails_#{version}" do
    gem "rails", "~> #{version}.0"
    if version == "7.0"
      gem "benchmark"
      gem "bigdecimal"
      gem "drb"
      gem "logger"
      gem "mutex_m"
    end
    gem "rails-controller-testing"
  end
end
