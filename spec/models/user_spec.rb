# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
  # tests go here
  subject { create(:user) }

  before { subject.save }

  it 'should be an admin' do
    expect(subject.admin?).to eq(true)
  end

  it 'has many addresses' do
    object = User.reflect_on_association(:addresses)
    expect(object.macro).to eq(:has_many)
  end

  it 'has many orders' do
    object = User.reflect_on_association(:orders)
    expect(object.macro).to eq(:has_many)
  end

  it 'has many wishlist items' do
    object = User.reflect_on_association(:wishlist_items)
    expect(object.macro).to eq(:has_many)
  end

  it 'has many otps' do
    object = User.reflect_on_association(:otps)
    expect(object.macro).to eq(:has_many)
  end

  it 'ensure authentication token' do
    expect(subject.authentication_token).not_to be_empty
  end

  it 'generate access token' do
    expect(subject.authentication_token).not_to be_empty
  end

  it 're-generate access token' do
    pre_authentication_token = subject.authentication_token
    expect(subject.regenerate_authentication_token).not_to eq(pre_authentication_token)
  end

  it 'generate otp and notify' do
    object = subject.generate_otp_and_notify
    otp = subject.otps.last.code
    expect(object.to_s).to include otp
  end

  it 'verify otp and save' do
    subject.generate_otp_and_notify
    otp = subject.otps.last.code
    subject.verify_otp_and_save(otp)
    expect(subject.otps.last.verified).to be true
  end
end
