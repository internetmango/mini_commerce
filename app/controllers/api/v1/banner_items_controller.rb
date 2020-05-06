# frozen_string_literal: true

module Api::V1
  class BannerItemsController < ApiController
    def index
      banner_items = BannerItem.all
      render_json(banner_items)
    end

    private

    def render_json(banner_items = nil)
      if banner_items
        serializer = BannerItemSerializer.new(banner_items)
        render json: serializer
      else
        render json: nil
      end
    end
  end
end
