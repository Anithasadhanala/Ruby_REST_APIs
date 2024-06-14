class ChangeColumnDtypeInSellerDetails < ActiveRecord::Migration[7.1]
  def change
    change_column :seller_details, :work_phone, :integer, null: false
    change_column_default :products, :avg_rating, 0.0

  end
end
