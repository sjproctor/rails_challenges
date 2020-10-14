require 'rails_helper'

RSpec.describe Animal, type: :model do

  # generic test
  it "is valid with valid attributes" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    expect(animal_test).to be_valid
  end

  # As the consumer of the API, I want to see validation errors if an animal doesn't include a common name.
  it "is not valid without a common_name" do
    animal_common_name_test = Animal.create common_name: nil, latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    expect(animal_common_name_test.errors[:common_name]).to_not be_empty
  end

  # As the consumer of the API, I want to see validation errors if an animal doesn't include a latin name.
  it "is not valid without a latin_name" do
    animal_latin_name_test = Animal.create common_name: "Red-winged blackbird", latin_name: nil, kingdom: "Animalia"
    expect(animal_latin_name_test.errors[:latin_name]).to_not be_empty
  end

  # As the consumer of the API, I want to see validation errors if an animal doesn't include a kingdom.
  it "is not valid without a kingdom" do
    animal_kingdom_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: nil
    expect(animal_kingdom_test.errors[:kingdom]).to_not be_empty
  end


  # As the consumer of the API, I want to see validation errors if a sighting doesn't include a date.
  it "is not valid without a date" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    sighting_test = Sighting.create longitude: 4, latitude: 78, date: nil, animal_id: animal_test.id
    expect(sighting_test.errors[:date]).to_not be_empty
  end

  # As the consumer of the API, I want to see a validation error if the animals latin name matches exactly the common name.
  it "cannot have the same value for common_name and latin_name" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Red-winged blackbird", kingdom: "Animalia"
    expect(animal_test.errors[:common_name]).to_not be_empty
    expect(animal_test.errors[:latin_name]).to_not be_empty
  end

  # As the consumer of the API, I want to see a validation error if the animals common name is not unique.
  it "must have a unique common_name" do
    animal_test_one = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    animal_test_two = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    expect(animal_test_two.errors[:common_name]).to_not be_empty
  end

  # As the consumer of the API, I want to see a validation error if the animals latin name is not unique.
  it "must have a unique latin_name" do
    animal_test_one = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    animal_test_two = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    expect(animal_test_two.errors[:latin_name]).to_not be_empty
  end

end
