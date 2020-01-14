class AnimalsController < ApplicationController

  # get a list of all the animals
  def index
    animals = Animal.all
    render json: animals
  end

  # get just one animal by id
  def show
    animal = Animal.find(params[:id])
    # return all the sightings for the animal
    render json: animal.to_json(include: :sightings)
  end

  # post a new animal to the database
  def create
    # create a new animal and call the params method to check for appropriate data
    animal = Animal.create(animal_params)
    # if the animal is created return the animal info
    if animal.valid?
      render json: animal
    # if the animal is not created return an error
    else
      render json: animal.errors, status: :unprocessable_entity
    end
  end

  # update an existing database entry
  def update
    animal = Animal.find(params[:id])
    # call the params method to check for appropriate data
    animal.update_attributes(animal_params)

    # if the animal is created return the animal info
    if animal.valid?
      render json: animal
    # if the animal is not created return an error
    else
      render json: animal.errors
    end
  end

  # remove one entry from the database
  def destroy
    animal = Animal.find(params[:id])
    # if the entry is deleted return the entry that was removed
    if animal.destroy
      render json: animal
    # if the entry was not deleted return an error
    else
      render json: animal.errors
    end
  end

  # setting params for the animal create and update methods
  def animal_params
    params.require(:animal).permit(:common_name, :latin_name, :kingdom, sightings_attributes: [:id, :longitude, :latitude, :date])
  end

end
