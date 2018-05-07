# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'

  add_group 'Core', 'lib/boechat'
  add_group 'Config', 'lib/boechat/core/config'
  add_group 'Service', 'lib/boechat/core/service'
end

RSpec::Mocks.configuration.allow_message_expectations_on_nil = true

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
  Kernel.srand config.seed
end
