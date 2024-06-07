class RenameRefreshTokensToUserRefreshTokens < ActiveRecord::Migration[7.1]
  def change
    rename_table :refresh_tokens, :user_refresh_tokens
  end
end
