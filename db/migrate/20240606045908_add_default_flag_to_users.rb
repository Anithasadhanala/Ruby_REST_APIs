class AddDefaultFlagToUsers < ActiveRecord::Migration[7.1]

      def change
        change_column_default :users, :flag, from: nil, to: true


  end
end
