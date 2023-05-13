class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name
      t.string :kind
      t.date :borned_at
      t.string :address
      t.string :phone_number
      t.string :email_address
      t.string :website
      t.text :activity_description
      t.string :activity_sector
      t.float :annual_turnover
      t.integer :number_of_employees
      t.string :legal_status
      t.string :registration_number
      t.string :region
      t.references :country, null: false, foreign_key: { to_table: :location_countries }, type: :uuid
      t.references :city, null: false, foreign_key: { to_table: :location_cities }, type: :uuid

      t.timestamps
    end
  end
end
