# frozen_string_literal: true

require 'boechat/core/service/request_list'
require 'pry'

RSpec.describe Boechat::Core::Service::RequestList do
  let(:requester_one) { -> { puts "I'm the one!" } }
  let(:requester_two) { -> { puts "I'm the two!" } }

  before { allow_any_instance_of(Proc).to receive(:call) }
  subject { described_class.new(requester_one: requester_one, requester_two: requester_two) }

  describe '#call' do
    context 'when an requester identifier IS passed' do
      context 'when the identifier EXISTS in requesters hash' do
        it 'run the correct requester' do
          subject.call(:requester_one)

          expect(requester_one).to have_received(:call).once
          expect(requester_two).not_to have_received(:call)
        end

        it 'return the correct object' do
          result = subject.call(:requester_one)

          expect(result).to be_an_instance_of(described_class)
        end
      end

      context 'when the identifier NOT EXISTS in requesters hash' do
        it "don't run any requester" do
          subject.call(:requester_three)

          expect(requester_one).not_to have_received(:call)
          expect(requester_two).not_to have_received(:call)
        end

        it 'return the correct object' do
          result = subject.call(:requester_one)

          expect(result).to be_an_instance_of(described_class)
        end
      end
    end

    context 'when an requester identifier IS NOT passed' do
      context 'when the identifier NOT EXISTS in requesters hash' do
        xit 'run all the requesters' do
        end
      end
    end
  end
end
