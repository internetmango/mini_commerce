# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Pagy::Backend

    before_action :set_user, only: %i[show edit update reset_password destroy]
    skip_before_action :verify_authenticity_token, only: [:destroy]

    def index
      @pagy, @users = pagy(User.order(admin: :desc), items: 4)
    end

    def new
      @user = User.new
    end

    def create
      User.create!(user_params)
      redirect_to admin_users_path,
                  notice: 'User was successfully created.'
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: 'Successfully updated user.'
      else
        Rails.logger.info(@user.errors.messages.inspect)
        render :edit
      end
    end

    def edit; end

    def destroy
      @user.destroy
      redirect_to admin_users_path,
                  notice: 'User was successfully destroyed.'
    end

    def reset_password
      @user.send_reset_password_instructions
      redirect_to admin_users_path,
                  notice: 'Password reset link has been sent.'
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
