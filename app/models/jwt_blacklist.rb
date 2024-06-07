class JwtBlacklist < ApplicationRecord
  belongs_to :user

  validates :jwt_token, presence: true, uniqueness: true

end
