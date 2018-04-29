# frozen_string_literal: true

# Module for safely include methods in String built-in class
module StringExtensions
  refine String do
    # Verifies if the string is a valid JSON format
    # If valid, returns true; otherwise false
    def valid_json?
      JSON.parse(self)
      true
    rescue JSON::ParserError
      false
    end
  end
end
