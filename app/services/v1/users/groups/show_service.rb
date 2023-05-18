# frozen_string_literal: true

module V1
  module Users
    module Groups
      # Show groups of a user.
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
          groups = @user.groups

          { success: true, payload: groups }
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'groups.notFound' }
        end
      end
    end
  end
end
