# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'boechat/version'

Gem::Specification.new do |spec|
  spec.name          = 'boechat'
  spec.version       = Boechat::VERSION
  spec.authors       = ['Danilo Barion Nogueira']
  spec.email         = ['danilo.barion@gmail.com']

  spec.summary       = 'Version verifier for BFFs and APIs'
  spec.description   = 'Verify the version of external APIs that your project depends on!'
  spec.homepage      = 'https://github.com/danilobarion1986/boechat'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.5.1'
  spec.metadata['yard.run'] = 'yri'

  spec.add_runtime_dependency 'dry-validation', '~> 0.11.1'
  spec.add_runtime_dependency 'oj', '~> 3.5'
  spec.add_runtime_dependency 'typhoeus', '~> 1.3'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubycritic'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
