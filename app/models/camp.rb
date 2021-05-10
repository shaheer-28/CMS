class Camp < ApplicationRecord
  require 'date'

  has_many :camps_locations, dependent: :destroy
  has_many :locations, through: :camps_locations
  has_many :camps_registrations, dependent: :destroy
  has_many :users, through: :camps_registrations

  ACTIVE = 'active'
  INACTIVE = 'inactive'

  validate :camp_dates

  def camp_dates
    return unless end_date < start_date

    errors.add :start_date, 'should be smaller than end date'
  end

  def active?
    self.status == ACTIVE
  end

  def inactive?
    self.status == INACTIVE
  end

  def allow_to_proceed?
    end_date > Date.today
  end
end
