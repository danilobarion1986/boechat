# frozen_string_literal: true

module Boechat
  module Core
    module Api
      # Classe encapsula todas as requisicoes do Typhoeus e executa conforme a chamada
      class Requests
        attr_reader :requests

        def initialize(requests = {})
          @requests = requests
        end

        def []=(key, requester)
          requests[key] = requester
        end

        def [](key)
          requests.fetch(key, NilRequest.new)
        end

        def run
          return self if requests.empty?
          # TODO: Tratar uma requisicao de apenas um objeto com request direto
          # sem a criacao de uma Hydra
          hydra = Typhoeus::Hydra.hydra
          requests.each_pair { |_key, req| hydra.queue(req.request) }
          hydra.run
          self
        end

        def run_healthcheck
          return :no_services if requests.empty?
          hydra = Typhoeus::Hydra.hydra
          requests.each_pair { |_key, req| hydra.queue(req.request_healthcheck) }
          hydra.run
          requests.map { |key, req| [key, req.healthcheck] }.to_h
        end
      end
    end
  end
end
