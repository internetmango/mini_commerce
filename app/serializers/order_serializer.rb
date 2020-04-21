# frozen_string_literal: true

class OrderSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :sub_total, :token,
             :status, :shipping_address_id,
             :billing_address_id, :order_number,
  			 :created_at, :updated_at
end
