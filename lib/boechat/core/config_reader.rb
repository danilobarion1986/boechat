# frozen_string_literal: true

require 'yaml'
require_relative 'config_wrapper'
require_relative 'config_schema_validator'

module Boechat
  module Core
    # Class responsible for read the boechat.yml file, that describes all endpoints to call
    class ConfigReader
      attr_reader :config_path

      def initialize
        app_root = Pathname.new(File.expand_path('../../../', __dir__))
        @config_path = File.join(app_root, 'config', 'boechat.yml')
      end

      def call
        result = validate_config_schema
        ConfigWrapper.new((result.success? ? result.output : {}), result.errors)
      end

      private

      def validate_config_schema
        ConfigSchemaValidator.call(File.read(@config_path))
      end
    end
  end
end
