class AddInstructions < ActiveRecord::Migration
  def change
    add_column :legs, :instructions, :string
  end
end
