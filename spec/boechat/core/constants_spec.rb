# frozen_string_literal: true

require 'boechat/internal/constants'

RSpec.describe Boechat::Internal::Constants do
  before do
    class ClassWithConstants
      include Boechat::Internal::Constants

      def boechat_constant
        BOECHAT_CONSTANT
      end
    end
  end

  after do
    Object.send(:remove_const, :ClassWithConstants)
  end

  subject { ClassWithConstants.new }

  it 'makes constants available in your class' do
    expect(subject.boechat_constant).to be Boechat::Internal::Constants::BOECHAT_CONSTANT
    expect(subject.boechat_constant).to eql(:value)
  end
end
