class CreateLocationCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :location_countries, id: :uuid do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :emoji
      t.string :code

      t.timestamps
    end
    add_index :location_countries, :code, unique: true
  end
end
