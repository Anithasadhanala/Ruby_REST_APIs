class AddFlagToArts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :flag, :boolean
  end
end
