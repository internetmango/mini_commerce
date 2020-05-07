# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    include Pagy::Backend

    before_action :set_user, except: [:index, :new, :create, :search]
    skip_before_action :verify_authenticity_token, only: [:destroy]

    def index
      @pagy, @users = pagy(User.where(admin: false).order(id: :desc))
    end

    def new
      @user = User.new
    end

    def show
      @orders = @user.orders.where('created_at >= ?', 1.month.ago).order(created_at: :desc)
      @addresses = @user.addresses
    end

    def create
      user = User.new(user_params)
      if user.save
        redirect_to admin_users_path,
                    notice: 'User was successfully created.'
      else
        render :new
      end
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
      if @user.destroy
        flash[:success] = 'User was successfully destroyed.'
      else
        flash[:error] = 'Error processing your request'
      end
      redirect_to admin_users_path
    end

    def reset_password
      if @user.send_reset_password_instructions
        flash[:success] = "Password reset link has been sent to #{@user.name}."
      else
        flash[:error] = 'Error processing your request'
      end
      redirect_to admin_users_path
    end

    def search
      if params[:q].present?
        value = params[:q]
        @pagy, @users = pagy(User.search_by_term(value))
      else
        @users = User.all
      end
      render :index
    end

    private

    def user_params
      params.require(:user).permit(
        :email, :mobile, :password,
        :password_confirmation, :name, :admin
      )
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end
