# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qonfig/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 2.5.0'

  spec.name        = 'qonfig'
  spec.version     = Qonfig::VERSION
  spec.authors     = ['Rustam Ibragimov']
  spec.email       = ['iamdaiver@icloud.com']
  spec.summary     = 'Config object'
  spec.description = 'Config. Defined as a class. Used as an instance. ' \
                     'Support for inheritance and composition. Lazy instantiation. Thread-safe. ' \
                     'Command-style DSL. Validation layer. ' \
                     'Support for YAML, TOML, JSON, __END__, ENV. ' \
                     'Extremely simple to define. Extremely simple to use.'
  spec.homepage    = 'https://github.com/0exp/qonfig'
  spec.license     = 'MIT'

  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.files = `git ls-files -z`.split("\x0")

  spec.add_development_dependency 'simplecov',        '~> 0.20'
  spec.add_development_dependency 'rspec',            '~> 3.10'
  spec.add_development_dependency 'armitage-rubocop', '~> 1.7'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'bundler-audit'
  spec.add_development_dependency 'ci-helper'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '>= 13'
  spec.add_development_dependency 'simplecov-lcov'
end
