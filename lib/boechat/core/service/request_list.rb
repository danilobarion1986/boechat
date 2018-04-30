# frozen_string_literal: true

module Boechat
  module Core
    module Service
      # Class to save all user request objects to execute them one at a time or all in parallel
      class RequestList
        attr_reader :requests

        def initialize(requests = {})
          @requests = requests
        end

        def call(request_identifier = nil)
          if request_identifier.nil?
            hydra = Typhoeus::Hydra.hydra
            requests.each_pair { |_key, request| hydra.queue(request.call) }
            hydra.run
          elsif requests.key?(request_identifier)
            requests[request_identifier].call
          end

          self
        end

        def []=(key, requester)
          requests[key] = requester
        end

        def [](key)
          requests[key]
        end
      end
    end
  end
end
