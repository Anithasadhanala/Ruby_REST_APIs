class AddColumnInOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :order_items, :quantity, :integer
  end
end
