class CreateCampsLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :camps_locations do |t|
      t.belongs_to :location, foreign_key: true
      t.belongs_to :camp, foreign_key: true
    end
  end
end
