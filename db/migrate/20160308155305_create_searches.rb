class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :place
      t.boolean :orientation
      t.integer :user_id
      t.float :lng
      t.float :lng
      t.timestamps
    end
  end
end
