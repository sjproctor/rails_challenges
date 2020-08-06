# Wildlife Tracker Challenge
The Forest Service is considering a proposal to place in conservancy a forest of virgin Douglas fir just outside of Portland. Before they give the go-ahead, they need to do an environmental impact study. They've asked you to build an app so that the rangers can report wildlife sightings.

### Set Up

- Create a new rails app
```
$ rails new wildlife_tracker -d postgresql -T
$ cd wildlife_tracker
$ rails db:create
$ bundle add rspec-rails
$ rails generate rspec:install
$ rails server
```
In a browser navigate to: `http://localhost:3000` or `127.0.0.1:3000` to view the Rails application

- Open Postman
- Headers >> key: content-type, value: application/json
- Navigate back to Params

### Process

#### Story: As the consumer of the API, I can list all animals in a database. Hint: make a few animals using Rails Console. (done)
- In terminal: `rails generate resource Animal common_name:string latin_name:string kingdom:string`
  - This creates the model, controller, view folder, and all the routes
- `rails db:migrate`
- `rails c`
- Add some content to the database:
  - `Animal.create common_name: 'Red Panda', latin_name: 'Ailurus fulgens', kingdom: 'mammal'`
  - `Animal.create common_name: 'Honey Mushroom', latin_name: 'Armillaria ostoyae', kingdom: 'fungus'`
  - `Animal.create common_name: 'Monarch Butterfly', latin_name: 'Danaus plexippus', kingdom: 'insect'`
  - `Animal.create common_name: 'Palm Tree', latin_name: 'Arecaceae', kingdom: 'plant'`
- Add `skip_before_action :verify_authenticity_token` to the file */app/controllers/application_controller.rb* which is the controller from which all other controllers inherit
- Add an `index` method to *animals_controller.rb*
```ruby
def index
    animals = Animal.all
    render json: animals
end
```
- In Postman create a `get` request for `localhost:3000/animals` and see the JSON response of all the animals in the database



#### Story: As the consumer of the API, I can create an animal and save it in the database. An animal has the following information: common_name, latin_name, kingdom. (done)
- Add a `create` method to *animals_controller.rb*
```ruby
def create
    animal = Animal.create(animal_params)
    if animal.valid?
      render json: animal
    else
      render json: animal.errors
    end
end
# the .create method is calling animal_params to ensure the data is created correctly
def animal_params
    params.require(:animal).permit(:common_name, :latin_name, :kingdom)
end
```
- In Postman navigate to `Body`
- Select `raw`
- Enter a JSON object for a new animal
```
{
  "animal": {
    "common_name": "Mongoose",
    "latin_name": "Herpestidae",
    "kingdom": "mammal"
  }
}
```
- Create a `post` request for `localhost:3000/animals` and see the JSON response of the newly created animal



#### Story: As the consumer of the API, I can update an animal in the database. (done)
- Add an `update` method to *animals_controller.rb*
```ruby
def update
    animal = Animal.find(params[:id])
    # the .update method is calling animal_params to ensure the data is created correctly
    animal.update_attributes(animal_params)

    if animal.valid?
      render json: animal
    else
      render json: animal.errors
    end
end
```
- In Postman navigate to `body`
- Make an edit to any of the values in the JSON object that was just created
```
{
   "animal": {
    "common_name": "Mongoose",
    "latin_name": "Herpestidae Bonaparte",
    "kingdom": "mammal"
    }
}
```
- Create a `patch` request for `localhost:3000/animals/5` (the id should match the id of the animal that was just created) and see the JSON response of the newly updated animal

#### Story: As the consumer of the API, I can destroy an animal in the database. (done)
- Add a `destroy` method to *animals_controller.rb*
```ruby
def destroy
  animals = Animal.find(params[:id])
  if animals.destroy
    render json: animal
  else
    render json: animal.errors
  end
end
```
- Create a `delete` request for `localhost:3000/animals/5` (the id must match an existing animal in the database) and see the JSON response of the newly deleted animal



#### Story: As the consumer of the API, I can create a sighting of an animal with date (use the datetime datatype), latitude and longitude.
- Sightings is a new table that will need to be created in the database
- `rails generate resource Sighting date:datetime latitude:integer longitude:integer animal_id:integer`
  - generate creates the model, controller, view folder, and all the routes
- `rails db:migrate`
- SIDE NOTE: Originally I forgot to add the foreign key to the sightings table so to fix that problem I did:
  - `rails g migration adds_foreign_key_to_sightings`
  - In the migration file, in the change method: `add_column :sightings, :animal_id, :integer` (got an error on :sighting so has to be :sightings)
  - `rails db:migrate`
- In *app/models/animal.rb* add `has_many :sightings` (plural)
- In *app/models/sighting.rb* add `belongs_to :animal` (singular)
- Add a series of new items to the database that belong to one of the animals already created
  - Created a variable to assign sightings to the first entry
  - `animal = Animal.first`
  - `animal.sightings.create date: Date.today.to_s, longitude: 34, latitude: 13`
  - `animal.sightings.create date: Date.today.to_s, longitude: 35, latitude: 12`
  - Reassigned the variable to add sightings to a different animal
  - `animal = Animal.where(common_name: 'Monarch Butterfly').first`
  - `animal.sightings.create date: Date.today.to_s, longitude: 34, latitude: 13`
  - `animal.sightings.create date: Date.today.to_s, longitude: 35, latitude: 12`
- Add an `index` method to *sightings_controller.rb*
```ruby
def index
  sightings = Sighting.all
  render json: sightings
end
```
- In Postman create a `get` request for `localhost:3000/sightings` and see the JSON response of all the sightings in the database
- Add a `create` method to *sightings_controller.rb*
```ruby
  def create
    sighting = Sighting.create(sighting_params)
    if sighting.valid?
      render json: sighting
    else
      render json: sighting.errors
    end
  end
  # the .create method is calling sighting_params to ensure the data is created correctly
  def sighting_params
    params.require(:sighting).permit(:animal_id, :latitude, :longitude, :date)
  end
```
- Enter a JSON object for a new sighting
```
{
 	"sighting": {
 	  "date": "2020-01-09T00:10:08.000Z",
 	  "latitude": 16,
    "longitude": 3,
    "animal_id": 1
  }
}
```
- In Postman create a `post` request for `localhost:3000/sightings` and see the JSON of the newly created sighting



#### Story: As the consumer of the API, I can update an animal sighting in the database. (done)
- Add an `update` method to *sightings_controller.rb*
```ruby
def update
    sighting = Sighting.find(params[:id])
    sighting.update_attributes(sighting_params)

    if sighting.valid?
    render json: sighting
    else
      render json: sighting.errors
    end
end
```



#### Story: As the consumer of the API, I can destroy an animal sighting in the database. (done)
- Add a `destroy` method to *sightings_controller.rb*
```ruby
def destroy
    sighting = Sighting.find(params[:id])
    if sighting.destroy
      render json: sighting
    else
      render json: sighting.errors
    end
end
```
- Create a `delete` request for `localhost:3000/sightings/2` (the id must match an existing animal in the database) and see the JSON response of the newly deleted sighting



#### Story: As the consumer of the API, when I view a specific animal, I can also see a list sightings of that animal. (done)
- Add a `show` method to *animals_controller.rb*
```ruby
def show
    animal = Animal.find(params[:id])
    render json: animal.to_json(include: :sightings)
end
```
- Create a `show` request for `localhost:3000/animals/1` (the id must match an existing animal in the database) and the JSON response of the one animal and multiple sightings


#### Story: As the consumer of the API, I can run a report to list all sightings during a given time period. (done)
- Update the `index` method in *sightings_controller.rb*
```ruby
def index
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    render json: sightings
end
```
- In Postman create a `get` request for `localhost:3000/sightings?start_date=2020-01-05T00:10:29.000Zend_date=2020-01-09T00:10:29.000Z` and see the JSON response of all the sightings in the database that fit that time period



#### Story: As the consumer of the API, I can submit sighting data along with new animals in 1 api call. (done)
- Add `accepts_nested_attributes_for :sightings` to *model/animal.rb*
- Add sightings_attributes to the animal_params method in *animals_controller.rb*
```ruby
  def animal_params
    params.require(:animal).permit(:common_name, :latin_name, :kingdom, sightings_attributes: [:id, :longitude, :latitude, :date])
  end
```
- Enter a JSON object for a new animal with a sighting
```
 {
 	"animal": {
 	    "common_name": "Monarch Butterfly",
        "latin_name": "Danaus plexippus",
        "kingdom": "insect",
        "sightings_attributes": [{
 			     "date": "2020-01-09T00:10:29.000Z",
 			     "latitude": 16,
        	 "longitude": 23
        }]
    }
}
```
- In Postman create a `post` request for `localhost:3000/animals` and see the JSON of the newly created animal
- Good resource: <a href="https://devopsdiarist.uk/rails-5-nested-attributes/" target="blank">Nested attributes</a>



#### Note: The remainder of the stories should include the proper RSPEC model and controller specs.
- To setup testing run `bundle add rspec-rails`
- If this is added prior to a generate resource command, the appropriate spec file will also be created
- If this is created after the generate command run `rails generate rspec:install`
- this installs a directory called `spec`
- look at the spec file
- (maybe)run `bundle install`
- Troubleshooting: from the project-level, run `bundle exec rspec`, or `rspec spec/models/animal_spec.rb` rather than running RSpec inside the spec or model file.


#### Story: As the consumer of the API, I want to see validation errors if an animal doesn't include a common name, or a latin name. (done)
- Create a file in the spec directory *spec/model/animal_spec.rb*
- Add tests to validate the existence of the model and each column
```ruby
require "rails_helper"

RSpec.describe "Animal", :type => :request do

  it "is valid with valid attributes" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    expect(animal_test).to be_valid
  end
  it "is not valid without a common_name" do
    animal_common_name_test = Animal.create common_name: nil, latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    expect(animal_common_name_test.errors[:common_name]).to_not be_empty
  end
end
```
- Repeat the `it` block for latin_name and kingdom
- Add validations to the Animal model class *app/models/animal.rb*
```
validates :common_name, presence: true
validates :latin_name, presence: true
validates :kingdom, presence: true
```
- In Postman create a `post` request for `localhost:3000/animals` without a common_name entry and see a validation error
```
{
  "common_name": [
    "can't be blank"
  ]
}
```



#### Story: As the consumer of the API, I want to see validation errors if a sighting doesn't include: latitude, longitude, or a date. (done)
- Create a file in the spec directory *spec/model/sighting_spec.rb*
- Add tests to validate the existence of the model and each column
```ruby
require "rails_helper"

RSpec.describe Sighting, type: :model do
# RSpec.describe "Sighting", :type => :request do
  it "is valid with valid attributes" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    sighting_test = Sighting.create date: "2020-01-11T00:10:29.000Z", longitude: 34, latitude: 38, animal_id: animal_test.id
    expect(sighting_test).to be_valid
  end

  it "is not valid without a date" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
    sighting_date_test = Sighting.create date: nil, longitude: 34, latitude: 38, animal_id: animal_test.id
    expect(sighting_date_test.errors[:date]).to_not be_empty
  end
end
```
- repeat the `it` block for longitude and latitude
- add validations to the Sighting model class *app/models/sighting.rb*
```
validates :date, presence: true
validates :longitude, presence: true
validates :latitude, presence: true
```
- In Postman create a `post` request for `localhost:3000/animals` without a longitude entry and see a validation error
```
{
  "sightings.longitude": [
    "can't be blank"
  ]
}
```


### Story: As the consumer of the API, I want to see a validation error if the animals latin name matches exactly the common name. (done)
- Add a test to check if the common_name and the latin_name are the same
```ruby
  it "cannot have the same value for common_name and latin_name" do
    animal_test = Animal.create common_name: "Red-winged blackbird", latin_name: "Red-winged blackbird", kingdom: "Animalia"
    expect(animal_test.errors[:common_name]).to_not be_empty
    expect(animal_test.errors[:latin_name]).to_not be_empty
  end
```
- Add a custom validation method to the Animal model class *app/models/animal.rb*
```ruby
validate :check_common_name_and_latin_name
def check_common_name_and_latin_name
  if self.common_name == self.latin_name
    errors.add(:common_name, "The names cannot be equal.")
    errors.add(:latin_name, "The names cannot be equal.")
  end
end
```



#### Story: As the consumer of the API, I want to see a validation error if the animals latin name or common name are not unique. (done)
- Add a test to determine if the common_name already exists
```ruby
it "must have a unique common_name" do
  animal_test_one = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
  animal_test_two = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
  expect(animal_test_two.errors[:common_name]).to_not be_empty
end
```
- Add logic to the Animal model class validations *app/models/animal.rb*
```
validates :common_name, presence: true, uniqueness: true
```
- Add a test to determine if the latin_name already exists
```ruby
it "must have a unique latin_name" do
  animal_test_one = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
  animal_test_two = Animal.create common_name: "Red-winged blackbird", latin_name: "Agelaius phoeniceus", kingdom: "Animalia"
  expect(animal_test_two.errors[:latin_name]).to_not be_empty
end
```
- Add logic to the Animal model class validations *app/models/animal.rb*
```ruby
validates :latin_name, presence: true, uniqueness: true
```

#### Story: As the consumer, I want to see a status code of 422 when a post request can not be completed because of validation errors.
