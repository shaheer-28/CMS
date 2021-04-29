class CreateCampRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :camps_registrations do |t|
      t.belongs_to :camp, index: true
      t.belongs_to :user, index: true

      t.date :dob, default: nil
      t.integer :age
      t.string :address,    default: ""
      t.string :gender,     default: "male"
      t.string :disability, default: ""
      t.string :medical_services,     default: ""
      t.string :activity_of_interest, default: ""
      t.boolean :is_first_camp,          default: true
      t.boolean :need_power_bank,     default: false
      t.string :social_media_presence,  default: ""
      t.string :emergency_contact,      default: ""
      t.text :suggestion

      t.timestamps
    end
  end
end
