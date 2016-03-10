class AddLatToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :lat, :float
  end
end
