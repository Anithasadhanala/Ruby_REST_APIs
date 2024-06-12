class CreateDeliveryUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :delivery_vehicle, null: false, foreign_key: true
      t.decimal :salary, null: false, precision: 10, scale: 2
      t.string :area_covering, null: false
      t.text :remarks
      t.string :vehicle_number, null: false

      t.timestamps
    end
  end
end
