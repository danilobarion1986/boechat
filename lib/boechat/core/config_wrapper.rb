# frozen_string_literal: true

require 'yaml'

module Boechat
  module Core
    # Class responsible for save all configurations readed from boechat.yml file
    class ConfigWrapper
      attr_reader :config
      DEFAULT_CONFIGURATION = '{}'

      def initialize(config)
        @config = YAML.safe_load(config || DEFAULT_CONFIGURATION)
      end
    end
  end
end
