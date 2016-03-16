class AddDuration < ActiveRecord::Migration
  def change
    add_column :legs, :duration, :integer, default: 0
  end
end
