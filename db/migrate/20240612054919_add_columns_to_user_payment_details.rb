class AddColumnsToUserPaymentDetails < ActiveRecord::Migration[7.1]
  def change
    add_column :user_payment_details, :bhim_upi, :string
    add_column :user_payment_details, :wallet_number, :string
  end
end
