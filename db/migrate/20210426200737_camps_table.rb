class CampsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :camps do |t|
      t.string :name,         null: false
      t.string :status,       null: false, default: "inactive"
      t.date :start_date,     null: false
      t.date :end_date,       null: false

      t.timestamps
    end
  end
end
