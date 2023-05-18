# frozen_string_literal: true

module V1
  module Users
    module Groups
      # Create a group for the given user with the specified attributes.
      #
      # properties - A Hash of attributes to set on the profile. The allowed keys are:
      #     - description: the description of the group
      #     - kind: the kind of the group (organization - user)
      #     - name: the name of the group
      #     - admin_id: the admin id
      #     - organization_id: the organization id
      #
      # Returns the created Group object if the record was saved successfully, or error if validation
      # failed.
      class CreateService < ApplicationCallable
        attr_reader :properties

        def initialize(properties)
          @properties = properties
        end

        def call
          admin         = ::User.find(@properties[:admin_id])
          organization  = ::Organization.find(@properties[:organization_id])

          group = ::Users::Group.create!(description: @properties[:description], kind: @properties[:kind],
                                         name: @properties[:name], admin:, organization:)

          { success: true, payload: group }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
