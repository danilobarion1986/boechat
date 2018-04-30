# frozen_string_literal: true

require 'boechat/core/config/schema_validator'
require 'dry-validation'

RSpec.describe Boechat::Core::Config::SchemaValidator do
  subject { described_class }

  describe '.call' do
    context 'when the config schema is INVALID' do
      let(:config) { '{}' }

      it 'returns and Dry::Validation::Result with errors' do
        result = subject.call(config)

        expect(result).to be_an_instance_of(Dry::Validation::Result)
        expect(result.errors).not_to be_empty
      end
    end

    context 'when the config schema is VALID' do
      let(:config) do
        "services:\n  - name: test\n    base_url: http://api.example.com.br\n"
      end

      it 'returns and Dry::Validation::Result without errors' do
        result = subject.call(config)

        expect(result).to be_an_instance_of(Dry::Validation::Result)
        expect(result.errors).to be_empty
      end
    end
  end
end
