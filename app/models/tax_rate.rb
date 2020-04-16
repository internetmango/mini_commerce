# frozen_string_literal: true

class TaxRate < ApplicationRecord
  validates :name, presence: true
  validates :rate, presence: true
end
