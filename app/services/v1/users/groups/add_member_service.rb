# frozen_string_literal: true

module V1
  module Users
    module Groups
      # Add a member to a group.
      #
      # group - The Group object to update.
      # properties - A Hash of attributes to set on the profile. The allowed keys are:
      #     - member_id: the member id of the user for adding to the group
      #
      # Returns the updated Group object if the record was saved successfully, or error if validation
      # failed.
      class AddMemberService < ApplicationCallable
        attr_reader :group, :properties

        def initialize(group, properties)
          @group      = group
          @properties = properties
        end

        def call
          member = ::User.find(@properties[:member_id])

          @group.users << member

          { success: true, payload: @group }
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'user.notFound' }
        end
      end
    end
  end
end
