# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

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
