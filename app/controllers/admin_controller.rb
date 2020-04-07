# frozen_string_literal: true

class AdminController < ApplicationController
  def authenticate_admin
    redirect_to new_user_session_path unless current_user.admin?
  end
  helper_method :authenticate_admin
end
