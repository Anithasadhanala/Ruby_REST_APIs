
class RenameTableNamePyments < ActiveRecord::Migration[7.1]
  def change
    rename_table :payments, :transactions
    change_column :transactions, :payment_mode, :string, null: false
  end
end
