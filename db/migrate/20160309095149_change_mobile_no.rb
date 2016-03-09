class ChangeMobileNo < ActiveRecord::Migration
  def change
    remove_column :users, :mobile_number
    add_column :users, :mobile_number, :string
  end
end
