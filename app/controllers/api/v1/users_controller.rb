# frozen_string_literal: true

module Api::V1
  # Products controller
  class UsersController < ApiController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :set_user, except: %i[index new create]
    respond_to :json

    def index
      users = User.order(admin: :desc)
      render json: users
    end

    def create
      user = User.create!(user_params)
      render json: user
    end

    def show
      render json: @user
    end

    def update
      user = @user.update(user_params)
      if user
        render json: user
      else
        Rails.logger.info(@user.errors.messages.inspect)
        render :edit
      end
    end

    def destroy
      @user.destroy
      render json: 'User was successfully destroyed.'
    end

    def reset_password
      @user.send_reset_password_instructions
      render json: 'Password reset link has been sent.'
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
