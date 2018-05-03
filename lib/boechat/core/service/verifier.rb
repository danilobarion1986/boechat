# frozen_string_literal: true

require_relative './requester'
require_relative './request_list'
require_relative './verifier_result'
require_relative '../config/reader'
require 'typhoeus'
require 'json'

module Boechat
  module Core
    module Service
      # Class responsible for call the endpoints and return all the results
      class Verifier
        attr_reader :config, :request_list

        def initialize
          @config = Config::Reader.new.call.config
          build_request_list
        end

        def call(service = nil)
          @request_list.call(service)
          VerifierResult.new(self)
        end

        private

        def build_request_list
          @request_list = RequestList.new

          @config['services'].each_with_index do |service, index|
            base_url = service['base_url']
            url = if base_url.end_with?('/')
                    "#{base_url}#{service['status_endpoint']}"
                  else
                    "#{base_url}/#{service['status_endpoint']}"
                  end
            @request_list.requesters[(service['name'] || index.to_s)] = Requester.new(url)
          end
        end
      end
    end
  end
end
