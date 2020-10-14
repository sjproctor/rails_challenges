class Sighting < ApplicationRecord
  belongs_to :animal

  validates :date, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  
end
