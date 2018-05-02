# frozen_string_literal: true

require 'boechat/core/service/request_list'

RSpec.describe Boechat::Core::Service::RequestList do
  subject { described_class }

  describe '#call' do
    context 'when an requester identifier IS passed' do
      context 'when the identifier EXISTS in requesters hash' do
        xit 'run the correct request' do
        end
      end

      context 'when the identifier NOT EXISTS in requesters hash' do
        xit 'run the correct request' do
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
