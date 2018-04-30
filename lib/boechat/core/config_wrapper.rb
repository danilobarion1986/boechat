# frozen_string_literal: true

module Boechat
  module Core
    # Class responsible for save all configurations readed from boechat.yml file
    class ConfigWrapper
      attr_reader :config, :errors

      def initialize(config, errors)
        @config = config
        @errors = errors
      end
    end
  end
end
