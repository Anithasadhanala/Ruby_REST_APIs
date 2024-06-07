class RenameUserRefreshTokensTableAndModifyColumns < ActiveRecord::Migration[6.1]
  def change

    rename_table :user_refresh_tokens, :user_jwt_tokens
    rename_column :user_jwt_tokens, :refresh_token, :jwt_token
    remove_column :user_jwt_tokens, :expiry_time, :datetime
    remove_column :user_jwt_tokens, :flag, :boolean
  end
end
