class ChangeColumnNameInSellers < ActiveRecord::Migration[7.1]
  def change
    rename_column :sellers, :rating, :avg_rating
  end
end
