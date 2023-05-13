# frozen_string_literal: true

namespace :location do
  desc 'Import all cities'
  task cities: :environment do
    CSV.foreach('lib/data/cities.csv', headers: true) do |row|
      # extraire les champs du CSV
      city_name     = row['name']
      latitude      = row['latitude']
      longitude     = row['longitude']
      country_code  = row['country_id']
      state_code    = row['state_id']

      # trouver l'objet Country correspondant
      country = Location::Country.find_by(code: country_code)
      state = Location::State.find_by(code: state_code, country:)

      # créer l'objet City lié au Country
      Location::City.create!(name: city_name, latitude:, longitude:, state:, country:)
    end
  end
end
