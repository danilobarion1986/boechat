# frozen_string_literal: true

module Boechat
  module Core
    module Api
      # Classe que faz o tratamento de resposta das requisicoes.
      # Deve ser estendida com as informacoes extras de service_uri e as_object
      class Request
        attr_reader :object, :response, :healthcheck
        HTTP_UNPROCESSABLE_ENTITY = 422

        def host
          raise MethodMissingError
        end

        def service_path
          raise MethodMissingError
        end

        def as_object(_body, _response)
          raise MethodMissingError
        end

        def parameters
          nil
        end

        def request_body
          nil
        end

        def http_body
          body = response.body

          return response_error if body.empty?
          return response_invalid_format unless body.valid_json?

          Oj.load(body, symbol_keys: true)
        end

        def response_error
          code = status

          case code
          when 404
            Oj.load({ error: 'Informação não encontrada', code: code }.to_json, symbol_keys: true)
          when 500
            Oj.load({ error: 'Erro interno da API', code: code }.to_json, symbol_keys: true)
          else
            Oj.load({ error: 'Erro não esperado', code: code }.to_json, symbol_keys: true)
          end
        end

        def response_invalid_format
          Oj.load({ error: 'Invalid JSON format', status: HTTP_UNPROCESSABLE_ENTITY }.to_json)
        end

        def status
          response.code
        end

        def success?
          response.success?
        end

        def method
          :get
        end

        def headers
          {}
        end

        def service_uri
          "#{host}#{service_path}"
        end

        def request
          Typhoeus::Request
            .new(service_uri, method: method, params: parameters, body: request_body, headers: http_header).tap do |req|
              handle_request(req)
            end
        end

        def handle_request(request)
          request.on_complete do |response|
            @response = response
            if response.success?
              @object = as_object(http_body, response)
              # elsif response.timed_out?
              #   Rails.logger.info('got a time out')
              #   # Poderiamos tentar requisitar mais uma vez
            else
              Rails.logger.warn("HTTP request failed: #{response.code}")
            end
          end
        end

        def request_healthcheck
          request = Typhoeus::Request.new("#{host}/healthcheck", params: parameters)
          @healthcheck = {}
          request.on_complete do |response|
            healthcheck[:status] = response.code
            healthcheck[:time] = response.total_time
          end
          request
        end

        private

        def http_header
          { 'User-Agent' => 'Boechat - API Version Verifier' }.merge(headers || {})
        end
      end
    end
  end
end
