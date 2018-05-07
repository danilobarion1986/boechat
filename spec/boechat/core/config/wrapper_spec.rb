# frozen_string_literal: true

require 'spec_helper'
require 'boechat/core/config/wrapper'

RSpec.describe Boechat::Core::Config::Wrapper do
  subject { described_class.new({}, {}) }

  it 'has @config and @errors attributes' do
    wrapper = subject

    expect(wrapper).to respond_to :config
    expect(wrapper).to respond_to :errors
  end
end
