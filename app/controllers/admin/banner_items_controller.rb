# frozen_string_literal: true

module Admin
  class BannerItemsController < AdminController
    include Pagy::Backend
    skip_before_action :verify_authenticity_token, only: :destroy
    before_action :set_banner_item, only: [:show, :edit, :update, :destroy]
    before_action :authorize_banner_item, only: [:show, :update, :destroy]
    before_action :authorize_banner_items, except: [:show, :update, :destroy]

    def index
      @pagy, @banner_items = pagy(BannerItem.order(updated_at: :desc))
    end

    def new
      @banner_item = BannerItem.new
    end

    def create
      banner_item = BannerItem.new(banner_item_params)
      if banner_item.save
        redirect_to admin_banner_items_path,
                    notice: 'Banner item was successfully created.'
      else
        render :new
      end
    end

    def update
      if @banner_item.update(banner_item_params)
        redirect_to admin_banner_item_path(@banner_item),
                    notice: 'Banner item was successfully updated.'
      else
        Rails.logger.info(@banner_item.errors.messages.inspect)
        render :edit
      end
    end

    def edit; end

    def destroy
      if @banner_item.destroy
        flash[:success] = 'Banner item was successfully destroyed'
      else
        flash[:error] = 'Error processing your request'
      end
      redirect_to admin_banner_items_path
    end

    private

    def banner_item_params
      params.require(:banner_item).permit(
        :title, :image_url,
        :mobile_params, :web_params
      )
    end

    def set_banner_item
      @banner_item = BannerItem.find(params[:id])
    end

    def authorize_banner_item
      authorize @banner_item
    end

    def authorize_banner_items
      authorize BannerItem
    end
  end
end
