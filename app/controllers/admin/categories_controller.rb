# frozen_string_literal: true

module Admin
  class CategoriesController < AdminController
    include Pagy::Backend
    skip_before_action :verify_authenticity_token, only: [:destroy]
    before_action :set_category, only: [:show, :edit, :update, :destroy]
    before_action :authorize_category, only: [:show, :update, :destroy]
    before_action :authorize_categories, except: [:show, :update, :destroy]

    def index
      @pagy, @categories = pagy(Category.order(updated_at: :desc))
    end

    def new
      @category = Category.new
    end

    def create
      category = Category.new(category_params)
      if category.save
        redirect_to admin_categories_path,
                    notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def update
      if @category.update(category_params)
        redirect_to admin_category_path(@category), notice: 'Category was successfully updated.'
      else
        Rails.logger.info(@category.errors.messages.inspect)
        render :edit
      end
    end

    def edit; end

    def destroy
      if @category.destroy
        flash[:success] = 'Category was successfully destroyed'
      else
        flash[:error] = 'Error processing your request'
      end
      redirect_to admin_categories_path
    end

    def search
      if params[:q].present?
        value = params[:q]
        @pagy, @categories = pagy(Category.search_by_term(value))
      else
        @categories = Category.all
      end
      render :index
    end

    private

    def category_params
      params.require(:category).permit(
        :name, :image
      )
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
  end
end
