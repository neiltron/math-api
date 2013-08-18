# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'math-api'

Gem::Specification.new do |gem|
  gem.name          = "math-api"
  gem.version       = Math::API::VERSION
  gem.authors       = ["Neil Pullman"]
  gem.email         = ["neil@descend.org"]
  gem.description   = %q{ API wrapper for Mathematics.io }
  gem.summary       = %q{ API wrapper for Mathematics.io }
  gem.homepage      = "http://github.com/neiltron/math-api"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
