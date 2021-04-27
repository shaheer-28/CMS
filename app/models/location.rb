class Location < ApplicationRecord
  has_many :camps_locations
  has_many :camps, through: :camps_locations

  validates :location, presence: true

  LOCATIONS_PER_PAGE = 10
  LOCATIONS_HEADERS = %w{ID Location}

  def self.search(search_key)
    return all if search_key.blank?

    where('location LIKE ?', "%#{ search_key }%")
  end
end
