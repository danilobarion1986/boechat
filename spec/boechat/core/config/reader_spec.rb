# frozen_string_literal: true

require 'boechat/core/config/reader'
require 'boechat/core/config/wrapper'

RSpec.describe Boechat::Core::Config::Reader do
  subject { described_class.new }

  describe '#call' do
    it 'returns an instance of Boechat::Core::Config::Wrapper class' do
      expect(subject.call).to be_an_instance_of(Boechat::Core::Config::Wrapper)
    end
  end
end
