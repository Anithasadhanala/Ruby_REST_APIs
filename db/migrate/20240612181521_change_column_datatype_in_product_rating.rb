class ChangeColumnDatatypeInProductRating < ActiveRecord::Migration[7.1]
  def change
    change_column :product_ratings, :rating, :float, null: false
  end
end
