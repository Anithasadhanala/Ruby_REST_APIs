class CreateJwtBlacklist < ActiveRecord::Migration[7.1]
  def change
    create_table :jwt_blacklists do |t|
      t.string :jwt_token, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :jwt_blacklists, :jwt_token, unique: true
  end
end
