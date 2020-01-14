class SightingsController < ApplicationController

  # get a list of all the sightings in a particular time range
  def index
    # Creating a parameter to get the sightings within a range of dates
    sightings = Sighting.where(date: params[:start_date]..params[:end_date])
    # if there are no date parameters passed render all the sightings
    if sightings.empty?
      render json: Sighting.all
    else
      render json: sightings
    end
  end
  # get just one sighting by id
  def show
    sighting = Animal.find(params[:id])
    render json: sighting
  end

  # post a new animal to the database
  def create
    # create a new sighting and call the params method to check for appropriate data
    sighting = Sighting.create(sighting_params)
    # if the sighting is created return the sighting info
    if sighting.valid?
      render json: sighting
    # if the animal is not created return an error
    else
      render json: sighting.errors
    end
  end

  # update an existing database entry
  def update
    sighting = Sighting.find(params[:id])
    # call the params method to check for appropriate data
    sighting.update_attributes(sighting_params)
    # if the sighting is created return the sighting info
    if sighting.valid?
      render json: sighting
    # if the sighting is not created return an error
    else
      render json: sighting.errors
    end
  end

  def destroy
    sighting = Sighting.find(params[:id])
    if sighting.destroy
      render json: sighting
    else
      render json: sighting.errors
    end
  end

  # setting params for the update method
  def sighting_params
    params.require(:sighting).permit(:animal_id, :latitude, :longitude, :date)
  end

end
