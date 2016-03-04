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

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("activesupport", ">= 3.1.0")
  s.add_development_dependency("pry")
end
