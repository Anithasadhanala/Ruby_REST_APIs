class RenameColumnInProductsTable < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :seller_id_id, :seller_id
  end
end
