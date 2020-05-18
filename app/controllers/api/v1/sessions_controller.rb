# frozen_string_literal: true

module Api::V1
  class SessionsController < ApiController
    skip_before_action :authenticate_user_with_api_token, only: :create
    skip_before_action :check_account_status

    def create
      user = User.find_by(mobile: login_params[:mobile]) if login_params[:mobile]
      user ||= User.find_by(email: login_params[:email]) if login_params[:email]

      render_404 && return unless user
      render_403 && return unless valid_params?

      password = login_params[:password]

      if !password
        if !login_params[:otp]
          status = user.generate_otp_and_notify
          if status != 'failure'
            render json: { status: 200, success: true, message: 'OTP has been sent' }
          else
            render json: { success: false, message: 'Error processing request' }
          end
        elsif user.verify_otp_and_save(login_params[:otp])
          token_reset_and_user_login(user)
        else
          render_403
        end
      elsif user.valid_password?(password)
        token_reset_and_user_login(user)
      else
        render_403
      end
    end

    def destroy
      if current_user.regenerate_authentication_token
        render json: { status: 200, success: true }
      else
        render json: { success: false, message: 'Error processing request' }
      end
    end

    private

    def login_params
      params.require(:session).permit(:mobile, :email, :password, :otp, :valid_till)
    end

    def logout_params
      params.permit(:email)
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

    def token_reset_and_user_login(user)
      user.regenerate_authentication_token
      login(user)
      render_json(user)
    end
  end
end
