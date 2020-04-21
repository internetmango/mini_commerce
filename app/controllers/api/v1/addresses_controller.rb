# frozen_string_literal: true

module Api::V1
  # Products controller
  class AddressesController < ApiController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_user_with_api_token
    before_action :set_user, except: %i[render_json]
    before_action :set_address, only: %i[show update destroy]
    before_action :authorize_address, only: %i[show update destroy]
    before_action :authorize_addresses, except: %i[show update destroy]
    respond_to :json

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

    def render_json(addresses = nil)
      if addresses
        serializer = AddressSerializer.new(addresses)
        render json: serializer
      else
        render json: []
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
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
