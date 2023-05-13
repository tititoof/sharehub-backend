class CreateLocationStates < ActiveRecord::Migration[7.0]
  def change
    create_table :location_states, id: :uuid do |t|
      t.string :name
      t.string :code
      t.references :country, null: false, foreign_key: { to_table: :location_countries }, type: :uuid, index: true

      t.timestamps
    end
  end
end
