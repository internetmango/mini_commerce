# frozen_string_literal: true

class TaxRate < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:name, :rate],
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  validates :name, presence: true
  validates :rate, presence: true
end
