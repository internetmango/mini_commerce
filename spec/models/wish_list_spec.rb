# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WishlistItem, type: :model do
  it 'should belongs to products' do
    wishlist = WishlistItem.reflect_on_association(:product)
    expect(wishlist.macro).to eq(:belongs_to)
  end

  it 'should belongs to a user' do
    wishlist = WishlistItem.reflect_on_association(:user)
    expect(wishlist.macro).to eq(:belongs_to)
  end
end
