# frozen_string_literal: true

require_relative './service/verifier'

module Boechat
  module Core
    # Class responsible for run the commands passed to the boechat binary
    class CommandRunner
      def self.call(command)
        if command == 'verify'
          verify_output
        else # runs help for help itself and any other not recognized command
          help_output
        end
      end

      private

      def verify_output
        puts '-' * 80
        puts 'Version Verification Result'
        puts Boechat::Core::Service::Verifier.new.call.result
        puts '-' * 80
      end

      def help_output
        output = <<~OUTPUT
          USAGE:
           boechat [COMMAND]
          COMMANDS:
           h, help          # Shows help instructions
           v, verify        # Verifies versions of all services contained in boachat.yml file

        OUTPUT
        puts output
      end
    end
  end
end
