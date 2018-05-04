appraise 'rails4.2' do
  gem 'rails', '~> 4.2.0'
end

rails_5x_version = ['~> 5.0.0', '~> 5.1.0', '~> 5.2.0']
rails_5x_version.each do |rails_version|
  appraise "rails#{rails_version.slice(/\d+\.\d+/)}" do
    gem 'rails', rails_version
    gem 'rails-controller-testing'
  end
end
