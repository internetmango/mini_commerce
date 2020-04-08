# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_admin

  def authenticate_admin
    redirect_to new_user_session_path unless current_user.admin?
  end
end
