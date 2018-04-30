# frozen_string_literal: true

require 'boechat/core/service/request'
require 'typhoeus'
require 'pry'

RSpec.describe Boechat::Core::Service::Request do
  subject { described_class }
  let(:url) { 'http://api.example.com' }

  describe '.new' do
    it 'creates an object with the correct attributes values' do
      request = subject.new(url)

      expect(request.service_uri).to eql(url)
      expect(request.verb).to eql(:get)
      expect(request.parameters).to eql(nil)
      expect(request.body).to eql(nil)
      expect(request.headers).to eql(nil)
      expect(request.request).to be_an_instance_of(Typhoeus::Request)
    end
  end

  describe '#http_header' do
    let(:basic_header) do
      { 'User-Agent' => 'Boechat - API Version Verifier' }
    end

    context 'when no custom header is given' do
      it 'returns only basic header info' do
        request = subject.new(url, headers: { custom_header_key: 'test' })
        binding.pry
        expect(request.send(:http_header)).to eql(basic_header.merge(request.headers))
      end
    end
  end
end
