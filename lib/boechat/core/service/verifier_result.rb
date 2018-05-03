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
        attr_reader :verifier

        def initialize(verifier)
          raise Internal::BoechatError.new("Verifier class expected, given #{verifier.class}.") unless verifier.class == Verifier
          @verifier = verifier
        end

        def call
          [].tap do |output|
            @verifier.request_list.requesters.each_pair do |key, requester|
              output << { name: key, parsed_response: requester.result.parsed_response, validation: :ok }
            end
          end
        end
      end
    end
  end
end
