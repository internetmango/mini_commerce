# frozen_string_literal: true

class ShippingMethod < ApplicationRecord
  validates :name, presence: true
  validates :code, presence: true
  validates :value_type, presence: true
  validates :value, presence: true
end
