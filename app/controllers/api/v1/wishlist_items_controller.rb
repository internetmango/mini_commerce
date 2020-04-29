# frozen_string_literal: true

module Api::V1
  class WishlistItemsController < ApiController
    before_action :set_wishlist_item, only: [:show, :update, :destroy]
    before_action :authorize_wishlist_item, only: [:show, :update, :destroy]
    before_action :authorize_wishlist_items, except: [:show, :update, :destroy]

    def index
      product_ids = current_user.wishlist_items.map(&:product_id)

      products = Product.find(product_ids)
      wishlist_items = ProductSerializer.new(products)
      render json: wishlist_items
    end

    def show
      @wishlist_item = Product.find(@wishlist_item.product_id)
      wishlist_item = ProductSerializer.new(@wishlist_item)
      render json: wishlist_item
    end

    def create
      wishlist_item = current_user.wishlist_items
                                  .where(product_id: wishlist_item_params[:product_id]).first
      if !wishlist_item
        wishlist_item = current_user.wishlist_items.build(wishlist_item_params)
        if wishlist_item.save
          render_json(wishlist_item)
        else
          render_json
        end
      else
        wishlist_item = wishlist_item
        render_json(wishlist_item)
      end
    end

    def update
      if @wishlist_item.update(wishlist_item_params)
        render_json(@wishlist_item)
      else
        render_json
      end
    end

    def destroy
      wishlist_item = @wishlist_item
      if @wishlist_item.destroy
        render_json(wishlist_item)
      else
        render_json
      end
    end

    private

    def render_json(wishlist_item = nil)
      if wishlist_item
        serializer = WishlistItemSerializer.new(wishlist_item)
        render json: serializer
      else
        render json: nil
      end
    end

    def set_wishlist_item
      @wishlist_item = current_user.wishlist_items.find(params[:id])
    end

    def authorize_wishlist_item
      authorize @wishlist_item
    end

    def authorize_wishlist_items
      authorize WishlistItem
    end

    # Only allow a list of trusted parameters through.
    def wishlist_item_params
      params.require(:wishlist_item).permit(
        :id, :product_id, :user_id
      )
    end
  end
end
