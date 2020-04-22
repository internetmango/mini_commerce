# frozen_string_literal: true

module Api::V1
  class UsersController < ApiController
    before_action :set_user, except: [:index, :create]

    def index
      users = User.order(admin: :desc)
      render_json(users)
    end

    def create
      if (user = User.create!(user_params))
        render_json(user)
      else
        render_json
      end
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
        render_json
      end
    end

    def destroy
      user = @user
      if @user.destroy
        render_json(user)
      else
        render_json
      end
    end

    def reset_password
      if @user.send_reset_password_instructions
        render_json(@user)
      else
        render_json
      end
    end

    private

    def render_json(value = nil)
      if value
        serializer = UserSerializer.new(value)
        render json: serializer
      else
        render json: nil
      end
    end

    def user_params
      params.require(:user).permit(
        :email, :password,
        :password_confirmation,
        :name, :admin
      )
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
