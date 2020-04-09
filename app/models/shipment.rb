# frozen_string_literal: true

class Shipment < ApplicationRecord
  validates :number, presence: true
  validates :order_id, presence: true
  validates :address_id, presence: true
end
