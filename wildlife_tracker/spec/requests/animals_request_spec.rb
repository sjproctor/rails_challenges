require 'rails_helper'

RSpec.describe "Animals", type: :request do

  # common_name must be present
  describe "POST #create" do
    it "returns a 422 custom status code if common_name is not present" do
      post '/animals', params: { animal: { common_name: "", latin_name: "Cervus canadensi", kingdom: "mammal" } }
      expect(response).to have_http_status(422)
    end

    # latin_name must be present
    it "returns a 422 custom status code if latin_name is not present" do
      post '/animals', params: { animal: { common_name: "Elk", latin_name: "", kingdom: "mammal" } }
      expect(response).to have_http_status(422)
    end

    # kingdom must be present
    it "returns a 422 custom status code if kingdom is not present" do
      post '/animals', params: { animal: { common_name: "Elk", latin_name: "Cervus canadensi", kingdom: "" } }
      expect(response).to have_http_status(422)
    end

    # common_name and latin_name cannot be the same
    it "returns a 422 custom status code if common_name and latin_name is the same" do
      post '/animals', params: { animal: { common_name: "Elk", latin_name: "Elk", kingdom: "mammal" } }
      expect(response).to have_http_status(422)
    end

    # common_name and latin_name already exist
    it "returns a 422 custom status code if common_name and latin_name already exist" do
      post '/animals', params: { animal: { common_name: "Elk", latin_name: "Cervus canadensi", kingdom: "mammal" } }
      post '/animals', params: { animal: { common_name: "Elk", latin_name: "Cervus canadensi", kingdom: "mammal" } }
      expect(response).to have_http_status(422)
    end

  end

end
