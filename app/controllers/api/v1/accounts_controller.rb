# frozen_string_literal: true

module Api::V1
  class AccountsController < ApiController
    def show
      render_json(current_user)
    end

    private

    def render_json(user = nil)
      if user
        serializer = UserSerializer.new(user)
        render json: serializer
      else
        render json: nil
      end
    end
  end
end
