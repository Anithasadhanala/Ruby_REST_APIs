class Delivery < ApplicationRecord
  belongs_to :buyer, class_name: 'User'
  belongs_to :delivery_user, class_name: 'User'
  belongs_to :order
end