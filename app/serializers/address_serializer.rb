# frozen_string_literal: true

class AddressSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :address_line1,
             :address_line2, :city,
             :zipcode, :state,
             :country, :phone,
             :user_id, :is_default,
             :address_type
end
