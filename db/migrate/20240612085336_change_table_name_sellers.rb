class ChangeTableNameSellers < ActiveRecord::Migration[7.1]
  def change


    rename_table :sellers, :seller_details
  end
end
