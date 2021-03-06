# frozen_string_literal: true

require_relative './requester'
require_relative './requester_list'
require_relative '../../errors'
require 'typhoeus'
require 'json'

module Boechat
  module Core
    module Service
      # Class responsible for call the endpoints and return all the results
      class VerifierResult
        attr_reader :verifier, :output

        class << self
          def call(verifier)
            raise BoechatError, "Verifier class expected, given #{verifier.class}." unless verifier.class == Verifier
            @verifier = verifier
            @output = []

            @verifier.requester_list.requesters.each_pair do |key, requester|
              next unless requester.result
              @output << { name: key,
                           parsed_response: requester.result.parsed_response,
                           valid_version: validate_response_version(key) }
            end

            @output
          end

          private

          def validate_response_version(requester_identifier)
            service_config = get_service_config(requester_identifier)
            current_version = get_service_current_version(requester_identifier, service_config['version_key'])
            return if current_version.nil?

            operator, required_version = service_config['version'].split(' ')
            comparer_method = operator.to_sym
            return unless current_version.respond_to?(comparer_method)

            current_version.send(comparer_method, required_version)
          end

          def get_service_config(requester_identifier)
            services = @verifier.config['services'].select do |service|
              service['name'] == requester_identifier
            end
            services.first
          end

          def get_service_current_version(requester_identifier, version_key = 'version')
            @verifier.requester_list[requester_identifier]
                     .result
                     .parsed_response[version_key.to_sym]
          end
        end
      end
    end
  end
end
