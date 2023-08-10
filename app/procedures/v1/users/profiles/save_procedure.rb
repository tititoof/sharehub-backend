# frozen_string_literal: true

module V1
  module Users
    module Profiles
      # Save (create or update) the profile for the given user with the specified attributes.
      #
      # user - The User object for which to create or update a profile.
      # properties - A Hash of attributes to set on the profile. The allowed keys are:
      #     - address: the user's address
      #     - date_of_birth: the user's date of birth
      #     - email: the user's email address
      #     - first_name: the user's first name
      #     - last_name: the user's last name
      #     - nickname: the user's nickname
      #     - phone: the user's phone number
      #     - city_id: the ID of the city where the user lives
      #
      # Returns the created or updated Profile object if the record was saved successfully, or error if validation
      # failed.
      class SaveProcedure < ApplicationCallable
        attr_reader :user, :properties

        def initialize(user, properties)
          @user       = user
          @properties = properties
        end

        def call
          payload = V1::Users::Profiles::UpdateService.call(@user, @properties) unless @user.profile.nil?

          payload = V1::Users::Profiles::CreateService.call(@user, @properties) if @user.profile.nil?

          { success: payload[:success], payload: payload[:payload] }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
