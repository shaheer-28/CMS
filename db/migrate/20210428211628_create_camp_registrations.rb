class CreateCampRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :camps_registrations do |t|
      t.belongs_to :camp, index: true
      t.belongs_to :user, index: true

      t.date :dob,            default: nil
      t.integer :age,         default: nil
      t.string :address,      default: nil
      t.string :gender,       default: nil
      t.string :disability,   default: ""
      t.string :medical_services,       default: ""
      t.string :activity_of_interest,   default: nil
      t.boolean :is_first_camp,         default: nil
      t.boolean :need_power_bank,       default: nil
      t.string :social_media_presence,  default: nil
      t.string :emergency_contact,      default: nil
      t.text :suggestion

      t.boolean :filled_screen1,  default: false
      t.boolean :filled_screen2,  default: false
      t.boolean :filled_screen3,  default: false
      t.boolean :filled_screen4,  default: false
      t.boolean :filled_screen5,  default: false
      t.boolean :filled_screen6,  default: false
      t.boolean :filled_screen7,  default: false
      t.boolean :filled_screen8,  default: false
      t.boolean :filled_screen9,  default: false
      t.boolean :filled_screen10, default: false

      t.boolean :application_complete,  default: false

      t.timestamps
    end
  end
end
