# frozen_string_literal: true

require 'boechat/core/service/response_handler'
require 'json'
require 'pry'

RSpec.describe Boechat::Core::Service::ResponseHandler do
  subject { described_class }
  Response = Struct.new(:body, :code)

  describe '.call' do
    context 'when the response was succesful' do
      let(:body) do
        { test_body: 'ok' }
      end
      let(:code) { 200 }
      let(:succesful_response) do
        Response.new(body.to_json, code)
      end

      it 'returns Hash with the correct structure and values' do
        handled_response = subject.call(succesful_response)

        expect(handled_response).to eql(body.merge(status: code))
      end
    end

    context 'when the response was NOT successful' do
      let(:body) do
        { test_body: 'not_ok' }.to_json
      end
      let(:failing_response) do
        Response.new(body, code)
      end

      context 'when has error 500' do
        let(:code) { 500 }

        it 'returns Hash with the correct structure and values' do
          handled_response = subject.call(failing_response)

          expect(handled_response).to eql(JSON.parse(body, symbolize_names: true).merge(status: code))
        end
      end

      context 'when has an empty body' do
        let(:body) { '' }

        context 'when has error 500' do
          let(:code) { 500 }

          it 'returns Hash with the correct structure and values' do
            handled_response = subject.call(failing_response)

            expect(handled_response).to eql(error: 'Service Internal Error', status: code)
          end
        end

        context 'when has error 404' do
          let(:code) { 404 }

          it 'returns Hash with the correct structure and values' do
            handled_response = subject.call(failing_response)

            expect(handled_response).to eql(error: 'Not Found', status: code)
          end
        end

        context 'when has an unexpected error code' do
          let(:code) { 400 }

          it 'returns Hash with the correct structure and values' do
            handled_response = subject.call(failing_response)

            expect(handled_response).to eql(error: 'Service Unexpected Error', status: code)
          end
        end
      end

      context 'when body has an invalid json format' do
        let(:body) do
          '{ "test_body": nil }'
        end
        let(:code) { 200 }

        it 'returns Hash with the correct structure and values' do
          handled_response = subject.call(failing_response)

          expect(handled_response).to eql(error: 'Invalid JSON format', status: 422)
        end
      end
    end
  end
end
