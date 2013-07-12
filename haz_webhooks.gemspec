# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'haz_webhooks/version'

Gem::Specification.new do |spec|
  spec.name          = "haz_webhooks"
  spec.version       = HazWebhooks::VERSION
  spec.authors       = ["Cameron Sutter"]
  spec.email         = ["csutter@instructure.com"]
  spec.description   = %q{Easily add and fire webhooks for any ActiveRecord model}
  spec.summary       = %q{Webhooks for Rails}
  spec.homepage      = ""
  spec.license       = "MIT"

  gem.add_dependency "activerecord"
  gem.add_dependency "httparty"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
