class Location < ApplicationRecord
  validates :location, presence: true

  LOCATIONS_PER_PAGE = 10
  LOCATIONS_HEADERS = ['ID', 'Location']

  def self.search(search_key)
    return all if search_key.blank?

    where('location LIKE ?', "%#{ search_key }%")
  end
end
