class SetDefaultQuantityInCarts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :carts, :quantity, from: nil, to: 1
  end
end
