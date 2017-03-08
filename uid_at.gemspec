# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uid_at/version'

Gem::Specification.new do |gem|
  gem.name          = "uid_at"
  gem.version       = UidAt::VERSION
  gem.authors       = ["Cezar Halmagean"]
  gem.email         = ["cezar@halmagean.ro"]
  gem.description   = %q{Fetch the Austrian UID}
  gem.summary       = %q{Validates european vat numbers with the Austrian "finanzonline". You need to be an Austrian company and sign up with finanzonline to use this.}
  gem.homepage      = ""

  gem.add_dependency("savon", "~> 1.2.0")
  gem.add_development_dependency("rspec", "~> 2.99.0")

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
