class Payment < ApplicationRecord
  belongs_to :order

  validates :order_id, presence: true
  validates :status, inclusion: { in: [true, false] }
end