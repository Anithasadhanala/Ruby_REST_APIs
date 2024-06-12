class ChangeTableNameProductRating < ActiveRecord::Migration[7.1]
  def change
    rename_table :product_rating, :product_ratings
  end
end
