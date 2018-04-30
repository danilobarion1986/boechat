# frozen_string_literal: true

require 'dry-validation'

module Boechat
  module Core
    module Config
      # Class responsible for validate the schema of the boechat.yml configuration file
      class SchemaValidator
        CONFIG_SCHEMA = Dry::Validation.Schema do
          required('services').each do
            schema do
              required('name').filled(:str?)
              required('base_url').filled(:str?)
              optional('status_endpoint').filled(:str?)
              optional('http_verb').filled(included_in?: %w[get post])
            end
          end
        end

        def self.call(config)
          CONFIG_SCHEMA.call(YAML.safe_load(config))
        end
      end
    end
  end
end
