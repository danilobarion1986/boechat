# frozen_string_literal: true

require 'spec_helper'
require 'boechat/core/service/requester'

RSpec.describe Boechat::Core::Service::Requester do
  subject { described_class }
  let(:url) { 'http://api.example.com' }

  describe '.new' do
    context 'when only required parameters are passed' do
      it 'creates an object with the correct attributes values' do
        request = subject.new(url)

        expect(request.service_uri).to eql(url)
        expect(request.parameters).to eql(nil)
        expect(request.body).to eql(nil)
        expect(request.headers).to eql(nil)
        expect(request.request).to be_an_instance_of(Typhoeus::Request)
      end
    end

    context 'when optional parameters are passed' do
      it 'creates an object with the correct attributes values' do
        custom_parameters = { id: 1 }
        custom_body = { token: 'xyz' }
        custom_header = { 'TEST' => 'value' }

        request = subject.new(url, parameters: custom_parameters,
                                   body: custom_body,
                                   headers: custom_header)

        expect(request.service_uri).to eql(url)
        expect(request.parameters).to eql(custom_parameters)
        expect(request.body).to eql(custom_body)
        expect(request.headers).to eql(custom_header)
        expect(request.request).to be_an_instance_of(Typhoeus::Request)
      end
    end
  end

  describe '#call' do
    context 'when a VALID url is passed' do
      it 'handle the request correctly' do
        url = 'https://api.genderize.io/?name=peter'

        requester = subject.new(url)
        requester.call

        expect(requester.result.success?).to be true
      end
    end

    context 'when an INVALID url is passed' do
      it 'handle the request correctly' do
        requester = subject.new(url)
        requester.call

        expect(requester.result.failure?).to be true
      end
    end
  end

  describe '#http_header' do
    let(:basic_header) do
      { 'User-Agent' => 'Boechat - API Version Verifier' }
    end

    context 'when custom header IS NOT given' do
      it 'returns only basic header info' do
        request = subject.new(url)

        expect(request.send(:http_header)).to eql(basic_header)
      end
    end

    context 'when custom header IS given' do
      it 'returns only basic header info' do
        request = subject.new(url, headers: { custom_header_key: 'test' })

        expect(request.send(:http_header)).to eql(basic_header.merge(request.headers))
      end
    end
  end
end
