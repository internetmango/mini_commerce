# frozen_string_literal: true

class WishlistItem < ApplicationRecord
  belongs_to :product
  belongs_to :user
end
