# frozen_string_literal: true

namespace :application do
    desc 'Initialize User and Organization'
    task init: :environment do
      user = User.create(email: 'admin@chartman2.fr', password: 'password', is_admin: true)
    end
  end