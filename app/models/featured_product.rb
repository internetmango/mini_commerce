# frozen_string_literal: true

class FeaturedProduct < ApplicationRecord
  include PgSearch::Model
  belongs_to :product
  pg_search_scope :search_by_term, against: [:listing_type],
                                   associated_against: {
                                     product: [:name, :description, :price]
                                   },

                                   using: {
                                     tsearch: { prefix: true }
                                   }
  validates :listing_type, presence: true
end
