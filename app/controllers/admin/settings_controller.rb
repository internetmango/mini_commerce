# frozen_string_literal: true

module Admin
  class SettingsController < AdminController
    include Pagy::Backend

    def admin_users
      @pagy, @users = pagy(User.where(admin: true).order(id: :desc))
    end
  end
end
