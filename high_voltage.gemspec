$:.push File.expand_path("../lib", __FILE__)
require "high_voltage/version"

Gem::Specification.new do |s|
  s.name        = 'high_voltage'
  s.version     = HighVoltage::VERSION.dup
  s.authors     = ['Matt Jankowski', 'Dan Croak', 'Nick Quaranto', 'Chad Pytel', 'Joe Ferris', 'J. Edward Dewyea', 'Tammer Saleh', 'Mike Burns', 'Tristan Dunn']
  s.email       = ['support@thoughtbot.com']
  s.homepage    = 'http://github.com/thoughtbot/high_voltage'
  s.summary     = 'Simple static page rendering controller'
  s.description = 'Fire in the disco. Fire in the ... taco bell.'
  s.license     = 'MIT'

  s.files         = `git ls-files -- {app,config,lib}/*`.split("\n")
  s.files        += %w[
    CHANGELOG.md
    CONTRIBUTING.md
    MIT-LICENSE
    README.md
  ]
  s.test_files    = []
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 3.0'
  s.add_development_dependency('activesupport', '>= 6.1')
  s.add_development_dependency('activemodel', '>= 6.1')
  s.add_development_dependency('appraisal')
  s.add_development_dependency('capybara')
  s.add_development_dependency('pry')
  s.add_development_dependency('rspec-rails', '~> 5.1.2')
end
