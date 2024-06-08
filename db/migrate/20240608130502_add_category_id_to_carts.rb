class AddCategoryIdToCarts < ActiveRecord::Migration[7.1]
  def change
    add_reference :carts, :category, foreign_key: true
  end
end
