class UserRefreshToken < ApplicationRecord
  belongs_to :user

  validates :refresh_token, presence: true, uniqueness: true
  validates :expiry_time, presence: true
  validates :user_id, presence: true

end
