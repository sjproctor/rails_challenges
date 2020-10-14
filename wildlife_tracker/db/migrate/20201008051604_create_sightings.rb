class CreateSightings < ActiveRecord::Migration[6.0]
  def change
    create_table :sightings do |t|
      t.datetime :date
      t.integer :latitude
      t.integer :longitude
      t.integer :animal_id

      t.timestamps
    end
  end
end
