class Camp < ApplicationRecord
  has_many :camps_locations, dependent: :destroy
  has_many :locations, through: :camps_locations
  has_many :camps_registrations, dependent: :destroy
  has_many :users, through: :camps_registrations

  STATUSES = { active: 'true', inactive: 'false' }

  validate :camp_dates

  def camp_dates
    return unless end_date < start_date

    errors.add :start_date, 'should be smaller than end date'
  end
end
