class AddInstructions < ActiveRecord::Migration
  def change
    add_column :directions, :instructions, :string
  end
end
