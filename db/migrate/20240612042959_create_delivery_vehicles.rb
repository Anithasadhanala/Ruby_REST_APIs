class CreateDeliveryVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_vehicles do |t|
      t.string :name, null: false
      t.text :description
      t.float :load, null: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
