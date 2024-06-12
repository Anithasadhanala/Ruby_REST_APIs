class ChangeColumnTableDeliveryUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :delivery_users, :user_id, :delivery_user_id
    rename_table :delivery_users, :delivery_user_details
  end
end
