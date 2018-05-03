# frozen_string_literal: true

require 'typhoeus'

module Boechat
  module Core
    module Service
      # Class to save all user request objects to execute them one at a time or all in parallel
      class RequestList
        attr_reader :requesters

        def initialize(requesters = {})
          @requesters = requesters
        end

        # @todo Add support for multiple HTTP Clients with parallel requests
        #   Initially only Typhoeus HTTP client is supported for make multiple API calls in parallel.
        #   It will be good to support other clients, as the user wants to configure
        def call(requester_identifier = nil)
          if requester_identifier.nil?
            hydra = Typhoeus::Hydra.hydra
            requesters.each_pair { |_key, requester| hydra.queue(requester.request) }
            hydra.run
          elsif requesters.key?(requester_identifier)
            requesters[requester_identifier].call
          end

          self
        end

        def []=(key, requester)
          requesters[key] = requester
        end

        def [](key)
          requesters[key]
        end
      end
    end
  end
end
