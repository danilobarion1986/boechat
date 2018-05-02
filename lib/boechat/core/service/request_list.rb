# frozen_string_literal: true

module Boechat
  module Core
    module Service
      # Class to save all user request objects to execute them one at a time or all in parallel
      class RequestList
        attr_reader :requesters

        def initialize(requesters = {})
          @requesters = requesters
        end

        def call(requester_identifier = nil)
          if requester_identifier.nil?
            hydra = Typhoeus::Hydra.hydra
            requesters.each_pair { |_key, requester| hydra.queue(requester.call) }
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
