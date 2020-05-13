# frozen_string_literal: true

class Product < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_term, against: [:name, :short_description, :description],
                                   using: {
                                     tsearch: { prefix: true }
                                   }
  validates :name, presence: true
  belongs_to :category
  has_many :product_images, dependent: :destroy
  has_one :product_stock, dependent: :destroy
  after_create :build_product_stock
  accepts_nested_attributes_for :product_images, allow_destroy: true

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
    attributes = ['Name', 'Category', 'Short Description', 'Description', 'Price']
    CSV.generate do |csv|
      csv << attributes
    end
  end

  def build_product_stock
    ProductStock.create(product_id: id)
  end

  def self.import(file)
    CSV.foreach(file, headers: true) do |row|
      product = row.to_hash
      category_name = product['category']
      category = Category.find_by(name: category_name)
      category = Category.create!(name: category_name) unless category
      category_id = category.id

      product['category_id'] = category_id
      product.delete('category')

      Product.create! product
    end
  end

  def self.generate_csv
    attributes = %w[name category short_description description price]
    CSV.generate do |csv|
      csv << attributes
    end
  end
end
