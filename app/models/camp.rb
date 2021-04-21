class Camp < ApplicationRecord
  validates :location, :presence => true

  CAMPS_PER_PAGE = 5
  CAMP_HEADERS = ['ID', 'Location']

  def self.search(search_key)
    return all if search_key.blank?

    where('location LIKE ?', "%#{ search_key }%")
  end
end
