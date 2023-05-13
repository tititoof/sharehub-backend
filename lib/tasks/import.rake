# frozen_string_literal: true

require 'csv'

namespace :import do
  desc 'Import all countries, states, cities'
  task init: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    Rake::Task['location:countries'].invoke
    Rake::Task['location:states'].invoke
    Rake::Task['location:cities'].invoke
  end
end
