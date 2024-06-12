class ChangeColumnTableSellerDetsils < ActiveRecord::Migration[7.1]
  def change
    rename_column :seller_details, :user_id, :buyer_id
  end
end
