# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scope_composer/version'

Gem::Specification.new do |spec|
  spec.name          = "scope_composer"
  spec.version       = ScopeComposer::VERSION
  spec.authors       = ["Jiří Zajpt"]
  spec.email         = ["jzajpt@blueberry.cz"]
  spec.summary       = %q{ScopeComposer is utility gem for AR composing scopes}
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
