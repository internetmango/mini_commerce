# frozen_string_literal: true

module Api::V1
  class LoginsController < ApiController
    skip_before_action :authenticate_user_with_api_token
    def create
      if login_params[:mobile]
        value = login_params[:mobile]
      elsif login_params[:email]
        value = login_params[:email]
      end

      if value
        if User.find_user_by(value)
          user = User.find_user_by(value)
        else
          render_404
        end
      else
        render json: { status: 403, success: false, message: 'Invalid credentials' }
      end

      if !login_params[:code] && user
        otp_code = Otp.generate_otp
        user_otp = user.otps.new(code: otp_code)
        UserMailer.with(user: user, otp: user_otp.code).info_email.deliver_now
        user_otp.save
        render json: { status: 200, success: true, message: 'OTP has been sent to your mail.' }
      elsif login_params[:code] && user
        otp = login_params[:code]
        if user.otps.where(code: otp)
          user_otp = user.otps.find_by(code: otp)
          user_otp.verified = true
          login(user)
          render_json(user)
        else
          render json: { status: 403, success: false, message: 'Invalid credentials' }
        end
      end
    end

    private

    def login_params
      params.require(:login).permit(:mobile, :email, :code, :valid_till)
    end

    def render_json(user = nil)
      if user
        serializer = UserSerializer.new(user)
        render json: serializer
      else
        render json: nil
      end
    end
  end
end
