# -*- encoding: utf-8 -*-
require File.expand_path('../lib/phishtank/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ezekiel Templin"]
  gem.email         = ["zeke@templ.in"]
  gem.description   = %q{Ruby interface to OpenDNS's PhishTank API}
  gem.summary       = %q{Provides a simple interface to work with OpenDNS's PhishTank developer API by handling caching and parsing of PhishTank data.}
  gem.homepage      = "https://github.com/ezkl/phishtank"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "phishtank"
  gem.require_paths = ["lib"]
  gem.version       = PhishTank::VERSION
  
  gem.add_dependency("typhoeus", "~> 0.3.3")
  gem.add_dependency("nokogiri", "~> 1.5.2")
  
  gem.add_development_dependency("rspec", "~> 2.8.0")
  gem.add_development_dependency("vcr", "~> 2.0.0")
end
