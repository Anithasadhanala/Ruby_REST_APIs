class SellerDetail < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
end