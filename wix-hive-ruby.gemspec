# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hive/version'

Gem::Specification.new do |spec|
  spec.name          = 'wix-hive-ruby'
  spec.version       = Hive::Version
  spec.authors       = ['David Zuckerman']
  spec.email         = ['davidz@wix.com']
  spec.summary       = 'Client to connect to Wix Hive APIs'
  spec.description   = 'TBD'
  spec.homepage      = 'http://dev.wix.com/docs'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|e2e)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard', '~> 2.6'
  spec.add_development_dependency 'guard-rspec', '~> 4.3'
  spec.add_development_dependency 'terminal-notifier-guard', '~> 1.5'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'webmock', '~> 1.18'
  spec.add_development_dependency 'rubocop', '~> 0.24'
  spec.add_development_dependency 'vcr', '~> 2.9'

  spec.add_dependency 'faraday', '~> 0.9.0', '>= 0.9.0'
  spec.add_dependency 'mime-types', '~> 1.25', '>= 1.25'
  spec.add_dependency 'json', '~> 1.8.1', '>= 1.8.1'
  spec.add_dependency 'hashie', '~> 3.2.0', '>= 3.2.0'
  spec.add_dependency 'faraday_middleware', '~> 0.9.1', '>= 0.9.1'
end
