class DropTableName < ActiveRecord::Migration[7.1]
  def change

        drop_table :jwt_blacklists


  end

end
