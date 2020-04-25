# frozen_string_literal: true

class FeaturedProduct < ApplicationRecord
  validates :listing_type, presence: true
end
