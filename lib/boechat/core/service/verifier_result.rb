# frozen_string_literal: true

require_relative './requester'
require_relative './request_list'
require_relative '../../internal/errors'
require 'typhoeus'
require 'json'

module Boechat
  module Core
    module Service
      # Class responsible for call the endpoints and return all the results
      class VerifierResult
        include Internal

        attr_reader :verifier

        def initialize(verifier)
          raise BoechatError, "Verifier class expected, given #{verifier.class}." unless verifier.class == Verifier
          @verifier = verifier
        end

        def call
          [].tap do |output|
            @verifier.request_list.requesters.each_pair do |key, requester|
              output << { name: key,
                          parsed_response: requester.result.parsed_response,
                          valid_version: validate_response_version(key) }
            end
          end
        end

        private

        def validate_response_version(requester_identifier)
          service_config = get_service_config(requester_identifier)
          current_version = get_service_current_version(requester_identifier)

          operator, required_version = service_config['version'].split(' ')

          current_version.send(operator.to_sym, required_version)
        end

        def get_service_config(requester_identifier)
          services = @verifier.config['services'].select do |service|
            service['name'] == requester_identifier
          end
          services.first
        end

        def get_service_current_version(requester_identifier)
          @verifier.request_list[requester_identifier].result.parsed_response[:tag_versao]
        end
      end
    end
  end
end
