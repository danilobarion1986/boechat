# frozen_string_literal: true

require_relative './request'
require_relative './requests'
require_relative '../config_reader'
require 'typhoeus'
require 'json'

module Boechat
  module Core
    module Service
      # Class responsible for call the endpoints and return all the results
      class VersionVerifier
        attr_reader :config

        def initialize
          @config = ConfigReader.new.call
        end

        def call
          results = call_endpoints

          results.map do |response|
            JSON.parse(response.body)
          end
        end

        private

        def call_endpoints
          requests = create_requests
          [].tap do |result|
            requests.each_pair do |_k, v|
              result << Typhoeus.get(v)
            end
          end
        end

        def create_requests
          requests = Requests.new
          @config.each_with_index do |config, index|
            requests[index.to_s] = config
          end
          requests.requests
        end
      end
    end
  end
end
