# frozen_string_literal: true

class Shipment < ApplicationRecord
  belongs_to :order
  belongs_to :address
  validates :number, presence: true
  validates :order_id, presence: true
  validates :address_id, presence: true
end
