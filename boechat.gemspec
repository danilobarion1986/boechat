# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'boechat/internal/version'

Gem::Specification.new do |spec|
  spec.name          = 'boechat'
  spec.version       = Boechat::Internal::VERSION
  spec.authors       = ['Danilo Barion Nogueira']
  spec.email         = ['danilo.barion@gmail.com']

  spec.summary       = 'Version verifier for BFFs and APIs'
  spec.description   = 'Verify the version of external APIs that your project depends on!'
  spec.homepage      = 'https://github.com/danilobarion1986/boechat'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # rubocop:disable Style/GuardClause
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end
  # rubocop:enable Style/GuardClause

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|bin)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.5.0'

  # Dependencies that your gem needs at runtime
  spec.add_runtime_dependency 'dry-validation', '~> 0.11.1'
  spec.add_runtime_dependency 'oj', '~> 3.5.0'
  spec.add_runtime_dependency 'typhoeus', '~> 1.3.0'

  # Dependencies that your gem needs only for development
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'dry-validation-matchers', '~> 0.4.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
