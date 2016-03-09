class AdCretorIdToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :creator_id, :integer
  end
end
