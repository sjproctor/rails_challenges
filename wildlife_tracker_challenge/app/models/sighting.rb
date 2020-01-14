class Sighting < ApplicationRecord
  # animal is singular
  belongs_to :animal
  # validations for sightings attributes
  validates :date, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
end
