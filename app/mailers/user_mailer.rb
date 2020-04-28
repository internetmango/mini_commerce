# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def login_otp
    @user = params[:user]
    @otp = params[:otp]
    mail(to: @user.email, subject: 'Mini shop login with otp')
  end
end
