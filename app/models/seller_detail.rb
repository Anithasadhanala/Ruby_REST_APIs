class SellerDetail < ApplicationRecord

  belongs_to :user, foreign_key: :buyer_id

  validates :store_name, presence: true
  validates :store_license , presence: true
  validates :work_phone, presence: true
  validates_format_of :store_name, with: /\A[a-zA-Z_-]+\z/, message: "can only contain alphabets, underscores, and dashes"


end