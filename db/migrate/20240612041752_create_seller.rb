class CreateSeller < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :store_name, null: false
      t.string :store_license, null: false
      t.string :work_phone, null: false
      t.float :rating
      t.boolean :is_active, default: true
      t.string :store_logo

      t.timestamps
    end
  end
end
