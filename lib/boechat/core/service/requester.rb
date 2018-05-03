# frozen_string_literal: true

require_relative '../../internal/string_extensions'
require_relative 'result'
require_relative 'response_handler'
require 'typhoeus'

module Boechat
  module Core
    # Module to group all classes related to the Request/Response/Validation cycle
    module Service
      using StringExtensions

      # Class responsible for make the request to one service
      class Requester
        attr_reader :request, :response, :result, :service_uri, :parameters, :body, :headers
        BASIC_HEADER = { 'User-Agent' => 'Boechat - API Version Verifier' }.freeze

        def initialize(service_uri, parameters: nil, body: nil, headers: nil)
          @service_uri = service_uri
          @parameters = parameters
          @body = body
          @headers = headers
          @request = Typhoeus::Request.new(@service_uri, method: :get, params: @parameters,
                                                         body: @body, headers: http_header)
        end

        def call
          @request.on_complete do |res|
            @response = res
            @result = Result.new(ResponseHandler.call(res))
          end
          @request.run
        end

        private

        def http_header
          return BASIC_HEADER.merge(@headers) if @headers
          BASIC_HEADER
        end
      end
    end
  end
end
