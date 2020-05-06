class Address < ApplicationRecord
  # all entries must exist
  validates :street_number, :street_name, :city, :state, :zip, presence: true
end
