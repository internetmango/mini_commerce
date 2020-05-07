# frozen_string_literal: true

class PaymentMethod < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:name, :description, :provider],
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  validates :name, :provider, presence: true
end
