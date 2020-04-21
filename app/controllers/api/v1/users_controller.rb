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
      render_json(users)
    end

    def create
      user = User.create!(user_params)
      render_json(user)
    end

    def show
      render_json(@user)
    end

    def update
      user = @user.update(user_params)
      if user
        render_json(user)
      else
        Rails.logger.info(@user.errors.messages.inspect)
        render_json('error')
      end
    end

    def destroy
      user = @user
      if @user.destroy
        render_json(user)
      else
        render_json('error')
      end
    end

    def reset_password
      @user.send_reset_password_instructions
      render_json(@user)
    end

    def render_json(users)
      if users != 'error'
        serializer = UserSerializer.new(users)
        render json: serializer
      else
        render json: []
      end
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
