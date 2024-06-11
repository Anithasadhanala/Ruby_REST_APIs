class ModifyCartTables < ActiveRecord::Migration[7.1]
  def change
    remove_column :carts, :category_id, :integer
  end

end
