# frozen_string_literal: true

module Api::V1
  class RegistersController < ApiController
    skip_before_action :authenticate_user_with_api_token
    skip_before_action :check_account_status

    def create
      user = User.find_by(email: register_params[:email]) if register_params[:email]
      user ||= User.find_by(mobile: register_params[:mobile]) if register_params[:mobile]

      render_403 && return unless valid_params?

      unless user
        email = register_params[:email] if register_params[:email]
        email ||= "user_#{SecureRandom.hex}@lvh.me"
        mobile = register_params[:mobile] if register_params[:mobile]
        password = SecureRandom.hex
        user = User.new(
          email: email, mobile: mobile, password: password,
          password_confirmation: password, active: false
        )
        unless user.save
          render_403 && return
        end

      end

      if !register_params[:otp]
        user.generate_otp_and_notify
        render json: { status: 200, success: true, message: 'OTP has been sent' }
      elsif user.verify_otp_and_save(register_params[:otp])
        user.regenerate_authentication_token
        activate_user(user)
        login(user)
        render_json(user)
      elsif user.destroy
        render json: { status: 403, success: false, message: 'otp invalid' }
      else
        render_500
      end
    end

    private

    def register_params
      params.require(:register).permit(:mobile, :email, :otp, :valid_till)
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
      register_params != nil
    end

    def activate_user(user)
      user.active = true
      user.save
    end
  end
end
