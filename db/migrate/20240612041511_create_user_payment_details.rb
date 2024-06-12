class CreateUserPaymentDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :user_payment_details do |t|
      t.references :user, null: false, foreign_key: true
      t.string :bank_name,null: false
      t.string :credit_card_number
      t.string :debit_card_number,null: false
      t.boolean :is_active, default: false

      t.timestamps
    end
  end
end
