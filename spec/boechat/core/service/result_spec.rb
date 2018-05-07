# frozen_string_literal: true

require 'spec_helper'
require 'boechat/core/service/result'

RSpec.describe Boechat::Core::Service::Result do
  subject { described_class }

  describe '.new' do
    let(:parsed_response) do
      { status: code }
    end

    context 'when is passed a successful response' do
      let(:code) { 304 }

      it 'reports success correctly' do
        result = subject.new(parsed_response)

        expect(result.success?).to be true
        expect(result.failure?).to be false
      end
    end

    context 'when is passed a NOT successful response' do
      let(:code) { 400 }

      it 'reports failure correctly' do
        result = subject.new(parsed_response)

        expect(result.success?).to be false
        expect(result.failure?).to be true
      end
    end
  end
end
