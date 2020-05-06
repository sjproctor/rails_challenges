class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street_number
      t.string :street_name
      t.string :city
      t.string :state
      t.string :zip
      t.integer :account_id

      t.timestamps
    end
  end
end
