class CampsLocation < ApplicationRecord
  belongs_to :camp
  belongs_to :location
end
