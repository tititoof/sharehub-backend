# frozen_string_literal: true

module V1
  module Organizations
    # Remove a member from a organization.
    #
    # organization - The Organization object to update.
    # properties - A Hash of attributes to set on the profile. The allowed keys are:
    #     - member_id: the member id of the user for adding to the organization
    #
    # Returns the updated Organization object if the record was saved successfully, or error if validation
    # failed.
    class AddMemberService < ApplicationCallable
      attr_reader :organization, :properties

      def initialize(organization, properties)
        @organization = organization
        @properties   = properties
      end

      def call
        member = ::User.find(@properties[:member_id])

        @organization.users.delete(member)
        @organization.save!

        { success: true, payload: @organization }
      rescue ActiveRecord::RecordNotFound => _e
        { success: false, errors: 'user.notFound' }
      end
    end
  end
end
