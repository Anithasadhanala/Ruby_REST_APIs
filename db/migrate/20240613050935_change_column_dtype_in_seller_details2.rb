class ChangeColumnDtypeInSellerDetails2 < ActiveRecord::Migration[7.1]
  def change
    change_column :seller_details, :avg_rating, :float, default: 0.0
  end
end
