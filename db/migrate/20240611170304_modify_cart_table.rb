class ModifyCartTable < ActiveRecord::Migration[6.0]
  def change

    rename_column :carts, :flag , :is_deleted
    # Removing the column
    remove_column :carts, :column_to_remove, :column_type # replace :column_type with the actual type of the column
    change_column_default :carts, :is_deleted, from: nil, to: false
  end
end
