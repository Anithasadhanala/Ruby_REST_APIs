class RenameColumnUserIdInProductReview < ActiveRecord::Migration[7.1]
  def change
    rename_column :product_reviews, :user_id, :buyer_id
  end
end
