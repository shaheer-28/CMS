class Camp < ApplicationRecord
  validates :location, presence: true
end
