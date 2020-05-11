# frozen_string_literal: true

class Category < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:name],
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  has_many :products, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true,
                   length: { maximum: 25 },
                   uniqueness: { case_sensitive: false }
end
