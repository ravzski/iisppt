class CreateDirections < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.string :from
      t.string :to
      t.float :from_lat
      t.float :from_lng
      t.float :to_lat
      t.float :to_lng
      t.integer :creator_id
      t.integer :user_id
      t.decimal :total_fare
      t.timestamps
    end

    create_table :legs do |t|
      t.integer :direction_id
      t.string :place
      t.string :transporation
      t.decimal :fare
      t.float :lat
      t.float :lng
    end
  end
end
