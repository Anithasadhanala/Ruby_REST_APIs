class CreateOrderTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :order_times do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
