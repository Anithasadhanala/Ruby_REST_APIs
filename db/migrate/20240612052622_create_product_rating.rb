# db/migrate/[timestamp]_create_product_reviews.rb

class CreateProductRating < ActiveRecord::Migration[6.0]
  def change
    create_table :product_rating do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
