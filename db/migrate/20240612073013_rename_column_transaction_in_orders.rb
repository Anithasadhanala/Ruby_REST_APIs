class RenameColumnTransactionInOrders < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :payment_id, :transaction_id
  end
end
