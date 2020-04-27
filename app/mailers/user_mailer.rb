# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def info_email
    @user = params[:user]
    @otp = params[:otp]
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: "otp has been send to #{@user.email}")
  end
end
