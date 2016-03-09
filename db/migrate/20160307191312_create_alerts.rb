class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :place
      t.text :event
      t.string :facility_type
      t.string :facility_name
      t.integer :user_id
      t.timestamps
    end
  end
end
