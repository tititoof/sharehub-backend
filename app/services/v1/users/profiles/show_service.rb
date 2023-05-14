# frozen_string_literal: true

module V1
  module Users
    module Profiles
      # Show profile of a user.
      #
      # user - The User object for which to create a profile.
      #
      # Returns the user Profile object if the record exist, or error if no record found.
      class ShowService < ApplicationCallable
        attr_reader :user

        def initialize(user)
          @user = user
        end

        def call
          profil = @user.profile

          { success: true, payload: profil }
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'profile.notFound' }
        end
      end
    end
  end
end
