class AddColumnInReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :product_reviews, :is_deleted, :boolean, default: false
  end
end
