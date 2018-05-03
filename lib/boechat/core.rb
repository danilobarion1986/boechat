# frozen_string_literal: true

require 'boechat/internal/version'
require 'boechat/core/service/verifier'
require 'pry'

# :nodoc:
module Boechat
  # :nodoc:
  module Core
    class Main
      def initialize
        verifier = Boechat::Core::Service::Verifier.new
        puts verifier.call.call.output
      end
    end
  end
end
