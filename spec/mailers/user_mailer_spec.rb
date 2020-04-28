# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'notify' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.with(user: user, otp: '765876').login_otp.deliver_now }

    it 'renders the headers' do
      expect(mail.subject).to eq('Mini shop login with otp')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end
  end
end
