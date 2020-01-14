require "rails_helper"

RSpec.describe "Animal", :type => :request do
  let!(:animal){ Animal.create }
  it "doesn't create a animal if there are validation errors" do
    animal.animal_params
    post '/animals', params: animal_params
  end
end
