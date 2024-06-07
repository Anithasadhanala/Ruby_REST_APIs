class CreateRefreshTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :refresh_tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :refresh_token, null: false
      t.datetime :timeexpiry, null: false
      t.boolean :flag, default: true
      t.timestamps
    end
    end
end
