# frozen_string_literal: true

require 'spec_helper'
require 'boechat/core/service/requester_list'
require 'boechat/core/service/requester'

RSpec.describe Boechat::Core::Service::RequesterList do
  let(:url) { 'http://api.example.com' }
  let(:requester_one) { Boechat::Core::Service::Requester.new(url) }
  let(:requester_two) { Boechat::Core::Service::Requester.new(url) }

  subject { described_class.new(requester_one: requester_one, requester_two: requester_two) }

  describe '#call' do
    before do
      allow(nil).to receive(:hydra=)
      allow(nil).to receive(:blocked?)
      allow(nil).to receive(:cacheable?)
      allow(nil).to receive(:memoizable?)
      allow(Typhoeus::Hydra.hydra).to receive(:run)
    end

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
      it 'run all the requesters' do
        expect(requester_one).to receive(:request).once
        expect(requester_two).to receive(:request).once

        subject.call
      end
    end
  end

  describe '#[]=' do
    context 'when an requester is passed with an key' do
      subject { described_class.new }

      context 'when it IS an instance of Requester class' do
        it 'is correctly saved in requesters attribute' do
          requester_four = Boechat::Core::Service::Requester.new(url)
          requester_list = subject

          requester_list[:four] = requester_four

          expect(requester_list.requesters.select { |key, _value| key == :four }).to eql(four: requester_four)
        end
      end

      context 'when it IS NOT an instance of Requester class' do
        it 'throw an ArgumentError' do
          expect { subject[:not_a_requester] = 1 }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe '#[]' do
    context 'when passed key EXISTS' do
      subject { described_class.new }

      it 'returns the correct requester' do
        requester_six = Boechat::Core::Service::Requester.new(url)
        requester_list = subject

        requester_list[:six] = requester_six

        expect(requester_list[:six]). to eql(requester_six)
      end
    end

    context 'when passed key DO NOT EXISTS' do
      subject { described_class.new }

      it 'returns the correct requester' do
        expect(subject[:seven]).to eql(nil)
      end
    end
  end
end
