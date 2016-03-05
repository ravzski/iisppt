class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.integer :creator_id
      t.integer :updator_id
      t.float :lat
      t.float :lng
      t.text :description
      t.string :info_type
      t.string :agency
      t.string :place
      t.datetime :end_date
      t.timestamps
    end
  end
end
