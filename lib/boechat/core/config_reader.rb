# frozen_string_literal: true

require 'yaml'

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
        YAML.safe_load(File.read(@config_path))
      end
    end
  end
end
