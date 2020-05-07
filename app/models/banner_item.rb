# frozen_string_literal: true

class BannerItem < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:title],
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  validates :title, :image_url, presence: true
end
