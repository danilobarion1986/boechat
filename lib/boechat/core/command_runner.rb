# frozen_string_literal: true

require_relative './service/verifier'

module Boechat
  module Core
    # Class responsible for run the commands passed to the boechat binary
    class CommandRunner
      def self.call(command)
        if command == 'verify'
          puts '-' * 80
          puts 'Version Verification Result'
          puts Boechat::Core::Service::Verifier.new.call.result
          puts '-' * 80
        else # runs help for help itself and any other not recognized command
          puts "\nUSAGE: \n  boechat [COMMAND]\n\nCOMMANDS:\n h, help\n v, verify\n c, console"
        end
      end
    end
  end
end
