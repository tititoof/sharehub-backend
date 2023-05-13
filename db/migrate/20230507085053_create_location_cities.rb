class CreateLocationCities < ActiveRecord::Migration[7.0]
  def change
    create_table :location_cities, id: :uuid do |t|
      t.string :name
      t.string :latitude
      t.string :longitude
      t.references :country, null: false, foreign_key: { to_table: :location_countries }, type: :uuid, index: true
      t.references :state, null: false, foreign_key: { to_table: :location_states }, type: :uuid, index: true

      t.timestamps
    end
  end
end
