# frozen_string_literal: true

module Boechat
  module Internal
    # A list of constants you can use to avoid memory allocations or identity checks.
    #
    # @example Just include this module to your class or module
    #   class Foo
    #     include Boechat::Internal::Constants
    #
    #     def call(value = EMPTY_ARRAY)
    #        value.map(&:to_s)
    #     end
    #   end
    module Constants
      BOECHAT_CONSTANT = :value
    end
  end
end
