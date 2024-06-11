class ModifyUserJwtTokens < ActiveRecord::Migration[7.1]
  def change
    add_column :user_jwt_tokens, :is_active, :boolean, default: true
  end
end
