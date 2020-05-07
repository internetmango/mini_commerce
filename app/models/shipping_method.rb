# frozen_string_literal: true

class ShippingMethod < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:name, :code, :value],
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  validates :name, :code, :value, :value_type, presence: true
end
