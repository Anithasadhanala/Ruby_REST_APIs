class Order < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
  belongs_to :transaction
  has_many :order_items
  has_many :products, through: :order_items

  validates :user_id, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_id, presence: true

end



