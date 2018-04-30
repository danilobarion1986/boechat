# frozen_string_literal: true

require_relative './request'
require_relative './request_list'
require_relative '../config/reader'
require 'typhoeus'
require 'json'

module Boechat
  module Core
    module Service
      # Class responsible for call the endpoints and return all the results
      class VersionVerifier
        attr_reader :config, :request_list

        def initialize
          @config = ConfigReader.new.call.config
          build_request_list
        end

        def call(service = nil)
          @request_list.call(service)
        end

        private

        def build_request_list
          @request_list = RequestList.new

          @config['services'].each do |service|
            key, value = service.first
            @request_list.requests[key] = Request.new(value['url'])
          end
        end
      end
    end
  end
end
