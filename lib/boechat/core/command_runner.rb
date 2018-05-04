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
          puts "\nUSAGE:"
          puts '  boechat [COMMAND]'
          puts "\nCOMMANDS:"
          puts '  h, help          # Shows help instructions'
          puts "  v, verify        # Verifies versions of all services contained in boachat.yml file\n"
        end
      end
    end
  end
end
