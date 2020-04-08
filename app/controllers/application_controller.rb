# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer
      .permit(:sign_up, keys: %i[name email password confirm_password remember_me])

    devise_parameter_sanitizer
      .permit(:account_update, keys: %i[name email password current_password])
  end
end
