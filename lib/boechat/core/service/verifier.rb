# frozen_string_literal: true

require_relative './requester'
require_relative './requester_list'
require_relative './verifier_result'
require_relative '../config/reader'
require 'typhoeus'
require 'json'

module Boechat
  module Core
    module Service
      # Class responsible for call the endpoints and return all the results
      class Verifier
        attr_reader :config, :requester_list, :result

        def initialize
          @config = Config::Reader.new.call.config
          @requester_list = RequestList.new
          build_requester_list
        end

        def call(service = nil)
          @requester_list.call(service)
          @result = VerifierResult.call(self)

          self
        end

        private

        def build_requester_list
          @config['services'].each_with_index do |service, index|
            identifier = service['name'] || index.to_s
            url = build_url(service)

            @requester_list.requesters[identifier] = Requester.new(url)
          end
        end

        def build_url(service)
          base_url = service['base_url']
          url = base_url.end_with?('/') ? base_url : "#{base_url}/"
          "#{url}#{service['status_endpoint']}"
        end
      end
    end
  end
end
