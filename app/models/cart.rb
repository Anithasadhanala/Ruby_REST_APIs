class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true

  scope :active, -> { where(flag: true) }


end