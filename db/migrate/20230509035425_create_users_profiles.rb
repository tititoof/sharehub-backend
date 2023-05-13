class CreateUsersProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :users_profiles, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :phone
      t.string :email
      t.date :date_of_birth
      t.string :nickname
      t.references :city, null: false, foreign_key: { to_table: :location_cities }, type: :uuid, null: true
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
