# frozen_string_literal: true

# Open countries CSV file
namespace :location do
  desc 'Import all countries'
  task countries: :environment do
    CSV.foreach('lib/data/countries.csv', col_sep: ',', headers: true) do |row|
      # Extraire les colonnes souhaitées
      name      = row['name']
      latitude  = row['latitude']
      longitude = row['longitude']
      code      = row['id']
      emoji     = row['emoji']

      # Créer un nouvel objet Country dans la base de données
      Location::Country.create!(name:, latitude:, longitude:, emoji:, code:)
    end
  end
end
