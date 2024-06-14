class UserJwtToken < ApplicationRecord
  belongs_to :user
  validates :jwt_token, presence: true, uniqueness: true


  # validates the all active records and send the ost recent jwt_token which is active
  def get_valid_token(user_id)

    existing_tokens = UserJwtToken.where(user_id: user_id).order(created_at: :desc)
    valid_token = existing_tokens.detect do |token|
      begin
        decoded_token = JWT.decode(token.jwt_token, "SECRET", true, algorithm: 'HS256')
        token_expiry = decoded_token[0]['expiry']
        Time.now.to_i < token_expiry && token.is_active == true
      end
    end
    valid_token
  end


  # generate jwt and stores
  def generate_jwt_token_and_store(user_id)
    payload = { user_id: user_id, expiry: Time.now.to_i + 360000 }
    jwt = JWT.encode(payload, "SECRET")
    UserJwtToken.create!(user_id: user_id, jwt_token: jwt, is_active: true)
  rescue => e
    errors.add(:base, "JWT token could not be created: #{e.message}")
    raise ActiveRecord::Rollback
  end



end

