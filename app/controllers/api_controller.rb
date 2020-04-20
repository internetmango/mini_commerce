# frozen_string_literal: true

class ApiController < ApplicationController


	def authenticate_user_with_api_token
    token = request.headers['token']
    email = request.headers['email']

    user = email && User.find_by(email: email)
    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = user
    else
      render status: 403,
             json: { success: false, message: t('api.messages.unauthorized') }
    end
  end
end
