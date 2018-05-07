# frozen_string_literal: true

require 'spec_helper'
require 'boechat/constants'

RSpec.describe Boechat::Constants do
  before do
    class ClassWithConstants
      include Boechat::Constants

      def regex_semver_format
        REGEX_SEMVER_FORMAT
      end
    end
  end

  after do
    Object.send(:remove_const, :ClassWithConstants)
  end

  subject { ClassWithConstants.new }

  it 'makes constants available in your class' do
    expect(subject.regex_semver_format).to be Boechat::Constants::REGEX_SEMVER_FORMAT
    expect(subject.regex_semver_format).to eql(/^(v\d*|0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(-(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*)?(\+[0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*)?$/)
  end
end
