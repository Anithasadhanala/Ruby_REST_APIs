class RenameColumnInUserRefreshTokens < ActiveRecord::Migration[7.1]
  def change
    rename_column :user_refresh_tokens, :timeexpiry, :expiry_time
  end
end
