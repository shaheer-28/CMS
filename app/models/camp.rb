class Camp < ApplicationRecord
  has_many :camps_locations
  has_many :locations, through: :camps_locations

  STATUSES = { active: 'active', inactive: 'inactive' }

  enum status: STATUSES

  validate :camp_dates

  def camp_dates
    return unless end_date < start_date

    errors.add :start_date, 'should be smaller than end date'
  end
end
