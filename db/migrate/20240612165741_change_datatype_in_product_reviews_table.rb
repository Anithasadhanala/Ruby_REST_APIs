class ChangeDatatypeInProductReviewsTable < ActiveRecord::Migration[7.1]
  def change
    def up
      change_column :product_reviews, :price, :integer
      change_column :product_reviews, :review, :text
    end

    def down
      change_column :product_reviews, :price, :text
      change_column :product_reviews, :review, :integer
    end
  end
end
