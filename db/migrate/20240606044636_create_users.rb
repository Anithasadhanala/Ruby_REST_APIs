class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :phone
      t.integer :age
      t.string :gender
      t.boolean :flag

      t.timestamps
    end
  end
end
