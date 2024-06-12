class RenameColumnUserIdInProductRating < ActiveRecord::Migration[7.1]
  def change
    rename_column :product_rating, :user_id, :buyer_id
  end
end
