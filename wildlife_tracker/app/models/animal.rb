class Animal < ApplicationRecord
  has_many :sightings
  accepts_nested_attributes_for :sightings

  validates :common_name, presence: true, uniqueness: true
  validates :latin_name, presence: true, uniqueness: true
  validates :kingdom, presence: true

  validate :check_common_name_and_latin_name
  def check_common_name_and_latin_name
    if self.common_name == self.latin_name
      errors.add(:common_name, "The names cannot be equal.")
      errors.add(:latin_name, "The names cannot be equal.")
    end
  end

end
