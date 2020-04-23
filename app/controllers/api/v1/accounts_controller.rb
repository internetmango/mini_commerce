# frozen_string_literal: true

module Api::V1
  class AccountsController < ApiController
    def show
      render_json(current_user)
    end

    private

    def render_json(addresses = nil)
      if addresses
        serializer = UserSerializer.new(addresses)
        render json: serializer
      else
        render json: nil
      end
    end
  end
end
