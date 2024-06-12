class ChangeDatatypeInProductReviewsTable3 < ActiveRecord::Migration[7.1]
  def change
    change_column :product_reviews, :review, :text
  end
end
