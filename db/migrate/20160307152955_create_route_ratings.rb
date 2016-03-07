class CreateRouteRatings < ActiveRecord::Migration
  def change
    create_table :route_ratings do |t|
      t.integer :user_id
      t.integer :rating
      t.string :from_place
      t.string :to_place
      t.integer :route_index
      t.timestamps
    end
  end
end
