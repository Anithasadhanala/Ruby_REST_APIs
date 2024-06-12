class ChangeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :product_reviews, :rating, :review
  end
end
