class RenameCampsToLocations < ActiveRecord::Migration[5.2]
  def self.up
    rename_table :camps, :locations
  end

  def self.down
    rename_table :locations, :camps
  end
end
