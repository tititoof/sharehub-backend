# frozen_string_literal: true

namespace :location do
  desc 'Cleaning states'
  task cleaning: :environment do
    Location::State.includes(:cities).where(cities: { id: nil }).destroy_all
  end
end