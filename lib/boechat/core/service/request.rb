# frozen_string_literal: true

require 'oj'
require_relative '../../internal/string_extensions'

module Boechat
  module Core
    module Service
      using StringExtensions

      # Class responsible for make the request to one service
      class Request
        attr_reader :request, :response, :parsed_response, :service_uri, :verb, :parameters, :body, :headers
        HTTP_UNPROCESSABLE_ENTITY = 422

        def initialize(service_uri, verb = :get, parameters = nil, body = nil, headers = nil)
          @service_uri = service_uri
          @verb = verb
          @parameters = parameters
          @body = body
          @headers = headers
          @request = Typhoeus::Request.new(@service_uri, method: @verb, params: @parameters,
                                                         body: @body, headers: http_header)
        end

        def call
          handle_request
        end

        private

        def http_header
          { 'User-Agent' => 'Boechat - API Version Verifier' }.tap do |header|
            header.merge(@headers) if @headers
          end
        end

        def handle_request
          @request.on_complete do |res|
            @response = res
            @parsed_response = Oj.load(http_body(res), symbol_keys: true)
          end
          @request.run
        end

        def http_body(response)
          body = response.body

          return response_error(response) if body.empty?
          return response_invalid_format unless body.valid_json?
          body
        end

        def response_error(response)
          code = response.code

          case code
          when 404
            Oj.load({ error: 'Not Found', code: code }.to_json, symbol_keys: true)
          when 500
            Oj.load({ error: 'Service Internal Error', code: code }.to_json, symbol_keys: true)
          else
            Oj.load({ error: 'Service Unexpected Error', code: code }.to_json, symbol_keys: true)
          end
        end

        def response_invalid_format
          Oj.load({ error: 'Invalid JSON format', status: HTTP_UNPROCESSABLE_ENTITY }.to_json)
        end
      end
    end
  end
end
