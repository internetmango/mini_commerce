# frozen_string_literal: true

module Api::V1
  # Products controller
  class CategoriesController < ApiController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :set_category, only: %i[show update destroy]
    before_action :authorize_category, only: %i[show update destroy]
    before_action :authorize_categories, except: %i[show update destroy]
    respond_to :json

    def index
      @categories = Category.order(:name)
      render_json(@categories)
    end

    def show
      render_json(@category)
    end

    def create
      @category = Category.create!(category_params)
      if @category
        render_json(@category)
      else
        render_json('error')
      end
    end

    def update
      if @category.update(category_params)
        render_json(@category)
      else
        render_json('error')
      end
    end

    def destroy
      category = @category
      if @category.destroy
        render_json(category)
      else
        render_json('error')
      end
    end

    def render_json(categories)
      if categories != 'error'
        serializer = CategorySerializer.new(categories)
        render json: serializer
      else
        render json: []
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def authorize_category
      authorize @category
    end

    def authorize_categories
      authorize Category
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
  end
end
