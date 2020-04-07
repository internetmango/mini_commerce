# frozen_string_literal: true

module Admin
  class DashboardsController < AdminController
    before_action :authenticate_admin
    def show
      @users = User.all
      @admins = @users.select(&:admin?)
    end
  end
end
