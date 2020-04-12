# frozen_string_literal: true

module Api::V1
  # Products controller
  class CategoriesController < AdminController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :authenticate_admin
    before_action :set_category, only: %i[show update destroy]
    respond_to :json

    def index
      @categories = Category.order(:name)
      render json: @categories
    end

    def show
      render json: @category
    end

    def create
      @category = Category.create!(category_params)
      if @category
        render json: @category
      else
        render :new
      end
    end

    def update
      if @category.update(category_params)
        render json: @category
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      render json: 'Category was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
  end
end
