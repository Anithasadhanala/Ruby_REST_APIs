class CreateAddress < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :state, null: false
      t.string :postal_code, null: false
      t.string :city, null: false
      t.string :landmark, null: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
