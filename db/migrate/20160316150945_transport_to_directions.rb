class TransportToDirections < ActiveRecord::Migration
  def change
    add_column :directions, :transporations, :string
  end
end
