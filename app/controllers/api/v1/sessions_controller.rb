# frozen_string_literal: true

module Api::V1
  class SessionsController < ApiController
    skip_before_action :authenticate_user_with_api_token

    def create
      user = User.find_by(email: login_params[:email]) if login_params[:email]
      user ||= User.find_by(mobile: login_params[:mobile]) if login_params[:mobile]

      render_404 && return unless user
      render_403 && return unless valid_params?

      if !login_params[:otp]
        user.generate_otp_and_notify
        render json: { status: 200, success: true, message: 'OTP has been sent' }
      elsif user.verify_otp_and_save(login_params[:otp])
        user.regenerate_authentication_token
        login(user)
        render_json(user)
      else
        render_403
      end
    end

    private

    def login_params
      params.require(:session).permit(:mobile, :email, :otp, :valid_till)
    end

    def render_json(user = nil)
      if user
        serializer = UserSerializer.new(user)
        render json: serializer
      else
        render json: nil
      end
    end

    def valid_params?
      login_params != nil
    end
  end
end
