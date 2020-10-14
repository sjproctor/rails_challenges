class AnimalsController < ApplicationController

  def index
      animals = Animal.all
      render json: animals
  end

  def create
      animal = Animal.create(animal_params)
      if animal.valid?
        render json: animal
      else
        render json: animal.errors, status: :unprocessable_entity
      end
  end

  def update
      animal = Animal.find(params[:id])
      animal.update(animal_params)
      if animal.valid?
        render json: animal
      else
        render json: animal.errors
      end
  end

  def destroy
    animals = Animal.find(params[:id])
    if animals.destroy
      render json: animal
    else
      render json: animal.errors
    end
  end

  def show
    animal = Animal.find(params[:id])
    render json: animal, include: :sightings

    # render json: animal.to_json(include: :sightings)
  end

  private
  def animal_params
    params.require(:animal).permit(:common_name, :latin_name, :kingdom, sightings_attributes: [:id, :longitude, :latitude, :date])
  end

end
