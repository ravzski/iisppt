class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :place
      t.string :event
      t.integer :user_id
      t.timestamps
    end
  end
end
