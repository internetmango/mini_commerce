# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true
  belongs_to :category
  has_many :product_images

  def self.import(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      product = row.to_hash.symbolize_keys

      category_name = product[:category].capitalize
      category = Category.find_by(name: category_name)
      category ||= Category.create!(name: category_name)

      Product.create!(product.except(:category).merge(category_id: category.id))
    end
  end

  def self.generate_csv
    attributes = %w[brand model description condition title price category image]
    CSV.generate do |csv|
      csv << attributes
    end
  end
end
