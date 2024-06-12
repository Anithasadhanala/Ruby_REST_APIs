class RenameColumnBuyerIdInOrders < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :user_id, :buyer_id
  end
end
