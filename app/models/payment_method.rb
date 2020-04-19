# frozen_string_literal: true

class PaymentMethod < ApplicationRecord
  validates :name, :provider, presence: true
end
