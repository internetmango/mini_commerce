# frozen_string_literal: true

class ApiController < ActionController::Base
  include Pundit
  protect_from_forgery

  rescue_from Exception, with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from Pundit::NotAuthorizedError, with: :render_unauthorized

  before_action :authenticate_user_with_api_token
  before_action :check_account_status
  around_action :set_locale

  respond_to :json

  def login(user)
    @current_user = user
  end

  def check_account_status
    return if current_user.active

    render json: { success: false, message: t('api.messages.please_activate_your_account') }
  end

  def authenticate_user_with_api_token
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    email = options.blank? ? nil : options[:email]

    user = email && User.find_by(email: email)
    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      @current_user = user
    else
      render_unauthorized
    end
  end

  def authenticate_user_with_password
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    email = options.blank? ? nil : options[:email]
    password = options.blank? ? nil : options[:password]

    user = email && User.find_by(email: email)

    if user.valid_password?(password)
      @current_user = user
    else
      render_unauthorized
    end
  end

  def render_403
    render status: :forbidden,
           json: { success: false, message: t('api.messages.invalid_credentials') }
  end

  def render_404
    render status: :not_found,
           json: { success: false, message: t('api.messages.not_found') }
  end

  def render_500
    render status: :internal_server_error,
           json: { success: false, message: t('api.messages.server_error') }
  end

  def render_unauthorized
    render status: :unauthorized,
           json: { success: false, message: t('api.messages.unauthorized') }
  end

  private

  def set_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
