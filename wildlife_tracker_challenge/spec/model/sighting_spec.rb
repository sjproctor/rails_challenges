require "rails_helper"

RSpec.describe "Sighting", :type => :request do
  # validates the model
  it "is valid with valid attributes" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    sighting_test = Sighting.create date: "2020-01-11T00:10:29.000Z", longitude: 34, latitude: 38, animal_id: animal_test.id
    expect(sighting_test).to be_valid
  end

  # validations tests for sighting having a date
  it "is not valid without a date" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    sighting_date_test = Sighting.create date: nil, longitude: 34, latitude: 38, animal_id: animal_test.id
    expect(sighting_date_test.errors[:date]).to_not be_empty
  end

  # validations tests for sighting having a longitude
  it "is not valid without a longitude" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    sighting_longitude_test = Sighting.create date: "2020-01-11T00:10:29.000Z", longitude: nil, latitude: 38, animal_id: animal_test.id
    expect(sighting_longitude_test.errors[:longitude]).to_not be_empty
  end

  # validations tests for sighting having a latitude
  it "is not valid without a latitude" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    sighting_latitude_test = Sighting.create date: "2020-01-11T00:10:29.000Z", longitude: nil, latitude: 38, animal_id: animal_test.id
    expect(sighting_latitude_test.errors[:longitude]).to_not be_empty
  end

end
