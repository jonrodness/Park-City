class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name
      t.string :official
      t.integer :streetNumber
      t.string :streetName
      t.string :ewStreet
      t.string :washroom
      t.string :nsstreet
      t.string :googleMapDest
      t.string :hectare
      t.integer :park_id

      t.timestamps null: false
    end
    add_index :parks, :park_id
  end
end
