class CreateDirectionsRating < ActiveRecord::Migration
  def change
    create_table :directions_ratings do |t|
      t.integer :user_id
      t.integer :direction_id
      t.integer :rating
      t.string :comment
      t.timestamps
    end

    add_column :route_ratings, :comment, :string
  end
end
