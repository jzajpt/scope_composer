# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scoping/version'

Gem::Specification.new do |spec|
  spec.name          = "scoping"
  spec.version       = Scoping::VERSION
  spec.authors       = ["Jiří Zajpt"]
  spec.email         = ["jzajpt@blueberry.cz"]
  spec.summary       = %q{Scoping is utility gem for AR composing scopes}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'activesupport'
end
