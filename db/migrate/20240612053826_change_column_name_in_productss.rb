class ChangeColumnNameInProductss < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :av_rating, :avg_rating
  end
end
