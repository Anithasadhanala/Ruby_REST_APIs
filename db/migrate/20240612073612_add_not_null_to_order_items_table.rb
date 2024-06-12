class AddNotNullToOrderItemsTable < ActiveRecord::Migration[7.1]
  def change
    change_column :order_items, :quantity, :integer, null: false
  end
end
