class Animal < ApplicationRecord
  # sightings is plural
  has_many :sightings

  # allows the creation of a new animal to include a sighting attribute
  accepts_nested_attributes_for :sightings

  # validations to make sure all columns have entries when creating or updating an entry
  validates :common_name, presence: true, uniqueness: true
  validates :latin_name, presence: true, uniqueness: true
  validates :kingdom, presence: true

  # creating a custom validation to check that common_name and latin_name are different from each other
  # validate calls the method
  validate :check_common_name_and_latin_name

  def check_common_name_and_latin_name
    # self is a special variable that points to the object that "owns" the currently executing code
    if self.common_name == self.latin_name
      # When initialized, every Rails model inheriting from ActiveRecord::Base implicitly instantiates an ActiveModel::Errors object. That object is accessible via the #errors method on the model’s instance and contains the errors generated when the model is validated on a create or update action
      errors.add(:common_name, "The names cannot be equal.")
      errors.add(:latin_name, "The names cannot be equal.")
    end
  end

end
