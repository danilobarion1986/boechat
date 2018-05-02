# frozen_string_literal: true

module Boechat
  module Internal
    # Custom error class
    #
    # @author Danilo Barion Nogueira
    # @since 0.0.1
    class BoechatError < StandardError
      # Constructor
      #
      # @param message [Object] Error message
      def initialize(message)
        super(message.to_s)
      end
    end
  end
end
