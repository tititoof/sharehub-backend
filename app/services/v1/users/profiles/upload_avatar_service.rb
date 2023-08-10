# frozen_string_literal: true

module V1
  module Users
    module Profiles
      # Save (create or update) the profile'avatar for the given user with the specified attributes.
      #
      # user - The User object for which to create a profile.
      # avatar - An image
      #
      # Returns the created or updated Profile object if the record was saved successfully, or error if validation
      # failed.
      class UploadAvatarService < ApplicationCallable
        attr_reader :user, :avatar

        def initialize(user, avatar)
          @user = user
          @avatar = avatar
        end

        def call
          @user.profile.avatar.purge if @user.profile.avatar.attached?

          @user.profile.avatar.attach(@avatar)

          { success: true, payload: @user.profile }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end