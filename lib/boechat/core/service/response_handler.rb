# frozen_string_literal: true

require 'oj'
require 'json'
require_relative '../../internal/string_extensions'

module Boechat
  module Core
    # Module to group all classes related to the Request/Response/Validation cycle
    module Service
      using StringExtensions

      # Class responsible for handle the response after Request has been called
      class ResponseHandler
        HTTP_UNPROCESSABLE_ENTITY = 422

        class << self
          def call(response)
            raise ArgumentError.new('Argument must respond to :body and :code') unless valid_response(response)
            body = response.body

            return response_error(response) if body.empty?
            return response_invalid_format unless body.valid_json?
            Oj.load(body, symbol_keys: true).merge(status: response.code)
          end

          private

          def valid_response(response)
            response.respond_to?(:body) && response.respond_to?(:code)
          end

          def response_error(response)
            code = response.code

            case code
            when 404
              Oj.load({ error: 'Not Found', status: code }.to_json, symbol_keys: true)
            when 500
              Oj.load({ error: 'Service Internal Error', status: code }.to_json, symbol_keys: true)
            else
              Oj.load({ error: 'Service Unexpected Error', status: code }.to_json, symbol_keys: true)
            end
          end

          def response_invalid_format
            Oj.load({ error: 'Invalid JSON format', status: HTTP_UNPROCESSABLE_ENTITY }.to_json, symbol_keys: true)
          end
        end
      end
    end
  end
end
