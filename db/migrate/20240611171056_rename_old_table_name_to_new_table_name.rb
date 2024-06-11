class RenameOldTableNameToNewTableName < ActiveRecord::Migration[7.1]
  def change
    rename_table :order_times, :order_items
  end
end
