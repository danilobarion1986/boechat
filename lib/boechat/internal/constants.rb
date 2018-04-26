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
      # Source: https://github.com/semver/semver/issues/232
      # rubocop:disable Metrics/LineLength
      REGEX_SEMVER_FORMAT = /^(v\d*|0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(-(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*)?(\+[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*)?$/
      # rubocop:enable Metrics/LineLength
    end
  end
end
