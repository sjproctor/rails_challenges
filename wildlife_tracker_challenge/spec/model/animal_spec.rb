require "rails_helper"

RSpec.describe "Animal", :type => :request do

  # validates the model
  it "is valid with valid attributes" do
    # creating a instance of Animal in the testing scope
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    # expects the animal_test is created and valid
    expect(animal_test).to be_valid
  end

  # validations tests for animal having a common_name
  it "is not valid without a common_name" do
    # creating a instance of Animal in the testing scope
    # set the common_name value to nil to create a test senario where the common_name attribute is left blank
    animal_common_name_test = Animal.create common_name: nil, latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    # expect an error to occur if the common_name attribute is blank
    expect(animal_common_name_test.errors[:common_name]).to_not be_empty
  end

  it "is not valid without a latin_name" do
    # creating a instance of Animal in the testing scope
    # set the latin_name value to nil to create a test senario where the latin_name attribute is left blank
    animal_latin_name_test = Animal.create common_name: "Red-winged blackbird", latin_name: nil, kingdom: "Animalia"
    # expect an error to occur if the latin_name attribute is blank
    expect(animal_latin_name_test.errors[:latin_name]).to_not be_empty
  end

  it "is not valid without a kingdom" do
    # creating a instance of Animal in the testing scope
    # set the kingdom value to nil to create a test senario where the kingdom attribute is left blank
    animal_kingdom_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: ""
    # expect an error to occur if the kingdom attribute is blank
    expect(animal_kingdom_test.errors[:kingdom]).to_not be_empty
  end

  it "cannot have the same value for common_name and latin_name" do
    # creating a instance of Animal in the testing scope
    # set the value of common_name and latin_name to be the same
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Red-winged blackbird", kingdom: "Animalia"
    # expect an error to occur if the common_name and the latin name are the same
    expect(animal_test.errors[:common_name]).to_not be_empty
    expect(animal_test.errors[:latin_name]).to_not be_empty
  end

end
