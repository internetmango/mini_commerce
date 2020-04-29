# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Otp, type: :model do
  subject { build(:otp) }

  it 'should belongs to a user' do
    otp = Otp.reflect_on_association(:user)
    expect(otp.macro).to eq(:belongs_to)
  end

  it 'should have a code' do
    subject.code = nil
    expect(subject).to_not be_valid
  end

  it 'should generate a random 6 digit code' do
    otp = Otp.generate_otp
    expect(otp.length).to eq(6)
  end
end
