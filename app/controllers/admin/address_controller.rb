# frozen_string_literal: true

module Admin
  class AddressController < AdminController
    # before_action :set_address, except: %i[index]
    # skip_before_action :verify_authenticity_token, only: [:destroy]

    def show
      user_id = @address.user_id
      @user = User.find(user_id)
    end

    # def edit; end

    # def update
    #   if @address.update(address_params)
    #     redirect_to admin_address_path(@address),
    #                 notice: 'Address was successfully updated.'
    #   else
    #     render :edit
    #   end
    # end

    # def destroy
    #   @address.destroy
    #   redirect_to admin_users_path,
    #               notice: 'address was successfully destroyed.'
    # end

    # private

    # def address_params
    #   params.require(:address).permit(
    #     :address_line1, :address_line2,
    #     :city, :zipcode, :state, :country, :phone, :user_id
    #   )
    # end

    # def set_address
    #   @address = Address.find(params[:id])
    # end
  end
end
