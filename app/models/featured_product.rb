# frozen_string_literal: true

class FeaturedProduct < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:name, :short_description, :description],
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  validates :listing_type, presence: true
end
