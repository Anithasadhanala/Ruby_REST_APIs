class ChangeColumnNameInProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :av_rating, :integer, null: false, default: 0
  end
end
