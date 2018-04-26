# frozen_string_literal: true

require_relative './request'

module Boechat
  module Core
    module Api
      # Classe que representa uma requisicao nula, para nao precisar tratar valores nulos
      class NilRequest < Request
        def service_uri
          raise 'Invalid request'
        end

        def as_object(_body, _response)
          nil
        end

        def status
          404
        end

        def success?
          false
        end
      end
    end
  end
end
