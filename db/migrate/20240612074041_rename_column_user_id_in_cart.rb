class RenameColumnUserIdInCart < ActiveRecord::Migration[7.1]
  def change
    rename_column :carts, :user_id, :buyer_id
  end
end
