class ChangeDatatypeInProductReviews < ActiveRecord::Migration[7.1]
  def change
    def up
      change_column :product_reviews, :price, :text
    end

    def down
      change_column :product_reviews, :price, :integer
    end
  end
end
