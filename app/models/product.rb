class Product < ApplicationRecord
  belongs_to :category
  belongs_to :seller, class_name: 'User'
  has_many :product_reviews
  has_many :product_ratings
  has_many :order_items
  has_many :orders, through: :order_items


  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end



