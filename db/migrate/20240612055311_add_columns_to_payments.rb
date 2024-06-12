class AddColumnsToPayments < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :payment_mode, :string
  end
end
