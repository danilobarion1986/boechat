# frozen_string_literal: true

require 'boechat/core/service/request_list'
require 'boechat/core/service/requester'

RSpec.describe Boechat::Core::Service::RequestList do
  let(:url) { 'http://api.example.com' }
  let(:requester_one) { Boechat::Core::Service::Requester.new(url) }
  let(:requester_two) { Boechat::Core::Service::Requester.new(url) }

  before { allow_any_instance_of(Proc).to receive(:call) }
  subject { described_class.new({ requester_one: requester_one, requester_two: requester_two}) }

  describe '#call' do
    context 'when an requester identifier IS passed' do
      context 'when the identifier EXISTS in requesters hash' do
        it 'run the correct requester' do
          expect(requester_one).to receive(:call).once
          expect(requester_two).not_to receive(:call)

          subject.call(:requester_one)
        end

        it 'return the correct object' do
          result = subject.call(:requester_one)

          expect(result).to be_an_instance_of(described_class)
        end
      end

      context 'when the identifier NOT EXISTS in requesters hash' do
        it "don't run any requester" do
          expect(requester_one).not_to receive(:call)
          expect(requester_two).not_to receive(:call)

          subject.call(:requester_three)
        end

        it 'return the correct object' do
          result = subject.call(:requester_one)

          expect(result).to be_an_instance_of(described_class)
        end
      end
    end

    context 'when an requester identifier IS NOT passed' do
      context 'when the identifier NOT EXISTS in requesters hash' do
        it 'run all the requesters' do
          expect(requester_one).to receive(:call).once
          expect(requester_two).to receive(:call).once

          subject.call
        end
      end
    end
  end
end
