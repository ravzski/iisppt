class UserNotifs < ActiveRecord::Migration
  def change
    create_table :user_alerts do |t|
      t.integer :user_id
      t.string :facility_type
      t.string :facility_name
      t.timestamps
    end
  end
end
