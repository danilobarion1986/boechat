# frozen_string_literal: true

module Boechat
  module Internal
    # Custom error classes for your gem
    class BoechatError < StandardError
      def initialize(message)
        super(message.to_s)
      end
    end
  end
end
