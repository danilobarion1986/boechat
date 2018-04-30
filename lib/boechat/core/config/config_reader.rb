# frozen_string_literal: true

require 'yaml'
require_relative 'config/wrapper'
require_relative 'config/schema_validator'

module Boechat
  module Core
    module Config
      # Class responsible for read the boechat.yml file, that describes all endpoints to call
      class Reader
        attr_reader :config_path

        def initialize
          app_root = Pathname.new(File.expand_path('../../../', __dir__))
          @config_path = File.join(app_root, 'config', 'boechat.yml')
        end

        def call
          result = validate_config_schema
          output = result.success? ? result.output : {}
          Wrapper.new(output, result.errors)
        end

        private

        def validate_config_schema
          SchemaValidator.call(File.read(@config_path))
        end
      end
    end
  end
end
