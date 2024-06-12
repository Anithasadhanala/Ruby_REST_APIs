# db/migrate/[timestamp]_create_deliveries.rb

class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.references :buyer, null: false, foreign_key: { to_table: :users }
      t.references :delivery_user, null: false, foreign_key: { to_table: :users }
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
