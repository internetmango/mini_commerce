# frozen_string_literal: true

module Api::V1
  class CategoriesController < ApiController
    before_action :set_category, only: [:show, :update, :destroy]
    before_action :authorize_category, only: [:show, :update, :destroy]
    before_action :authorize_categories, except: [:show, :update, :destroy]

    def index
      categories = Category.order(:name)
      render_json(categories)
    end

    def show
      render_json(@category)
    end

    def create
      @category = Category.create!(category_params)
      if @category
        render_json(@category)
      else
        render_json
      end
    end

    def update
      if @category.update(category_params)
        render_json(@category)
      else
        render_json
      end
    end

    def destroy
      category = @category
      if @category.destroy
        render_json(category)
      else
        render_json
      end
    end

    private

    def render_json(categories = nil)
      if categories
        serializer = CategorySerializer.new(categories)
        render json: serializer
      else
        render json: nil
      end
    end

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
      params.require(:category).permit(:name, :image)
    end
  end
end
