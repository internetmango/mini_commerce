# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

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
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer
      .permit(:sign_up, keys: %i[name email password confirm_password remember_me])

    devise_parameter_sanitizer
      .permit(:account_update, keys: %i[name email password current_password])
  end

  def user_not_authorized(_exception)
    flash[:warning] = 'Sorry this page is only accessible by admin'
    redirect_to(request.referrer || root_path)
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
