class Order < ApplicationRecord
  belongs_to :user
  has_one :payment

  validates :user_id, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_id, presence: true
end