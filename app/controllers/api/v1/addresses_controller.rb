# frozen_string_literal: true

module Api::V1
  class AddressesController < ApiController
    before_action :set_user, except: [:show, :update]
    before_action :set_address, only: [:show, :update, :destroy]
    before_action :authorize_address, only: [:show, :update, :destroy]
    before_action :authorize_addresses, except: [:show, :update, :destroy]

    def index
      addresses = @user.addresses.order(:created_at)
      render_json(addresses)
    end

    def show
      render_json(@address)
    end

    def create
      @address = @user.addresses.create!(address_params)
      if @address
        render_json(@address)
      else
        render_json
      end
    end

    def update
      if @address.update(address_params)
        render_json(@address)
      else
        render_json
      end
    end

    def destroy
      address = @address
      if @address.destroy
        render_json(address)
      else
        render_json
      end
    end

    private

    def render_json(addresses = nil)
      if addresses
        serializer = AddressSerializer.new(addresses)
        render json: serializer
      else
        render json: nil
      end
    end

    def set_address
      @address = @user.addresses.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def authorize_address
      authorize @address
    end

    def authorize_addresses
      authorize Address
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(
        :id, :address_line1, :address_line2,
        :city, :zipcode, :state, :country, :phone,
        :user_id, :is_default, :address_type
      )
    end
  end
end
