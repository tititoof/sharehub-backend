# frozen_string_literal: true

namespace :location do
  desc 'Import all states'
  task states: :environment do
    CSV.foreach('lib/data/states.csv', headers: true) do |row|
      name          = row['name']
      state_code    = row['id']
      country_code  = row['country_id']

      country = Location::Country.find_by(code: country_code)

      Location::State.create!(name:, code: state_code, country:)
    end
  end
end
