# frozen_string_literal: true

require 'oj'

module Boechat
  module Core
    module Service
      # Class responsible for store the response of the Request class
      class Result
        attr_reader :parsed_response

        def initialize(parsed_response)
          @parsed_response = parsed_response
        end

        def success?
          @parsed_response && @parsed_response[:status] < 400
        end

        def failure?
          @parsed_response && @parsed_response[:status] >= 400
        end
      end
    end
  end
end
