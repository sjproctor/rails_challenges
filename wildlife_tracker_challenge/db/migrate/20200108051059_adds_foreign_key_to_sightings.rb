class AddsForeignKeyToSightings < ActiveRecord::Migration[6.0]
  def change
    add_column :sightings, :animal_id, :integer
  end
end
