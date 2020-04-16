# frozen_string_literal: true

module Admin
  module Settings
    class AdminUsersController < AdminController
      include Pagy::Backend

      def index
        @pagy, @users = pagy(User.where(admin: true).order(id: :desc))
      end
    end
  end
end
