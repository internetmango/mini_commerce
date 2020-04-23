# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  around_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer
      .permit(:sign_up, keys: [:name, :email, :password, :confirm_password, :remember_me])

    devise_parameter_sanitizer
      .permit(:account_update, keys: [:name, :email, :password, :current_password])
  end

  def user_not_authorized(_exception)
    flash[:warning] = 'Sorry this page is only accessible by admin'
    redirect_to(request.referrer || root_path)
  end

  private

  def after_sign_in_path_for(_resource)
    stored_location_for(_resource) || root_path
  end

  def set_locale(&action)
    session[:locale] = params[:locale] || session[:locale] || I18n.default_locale
    I18n.with_locale(session[:locale], &action)
  end
end
