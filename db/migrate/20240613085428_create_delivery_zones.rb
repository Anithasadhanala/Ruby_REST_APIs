class CreateDeliveryZones < ActiveRecord::Migration[7.1]
  def change
    create_table :delivery_zones do |t|
      t.string :name, null: false
      t.string :description, null: false

      t.timestamps null: false
    end
  end
end
