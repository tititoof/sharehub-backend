# frozen_string_literal: true

module V1
  module Projects
    # Add a member to a project.
    #
    # project - The Project object to update.
    # properties - A Hash of attributes to set on the profile. The allowed keys are:
    #     - member_id: the member id of the user for adding to the project
    #
    # Returns the updated Project object if the record was saved successfully, or error if validation
    # failed.
    class AddMemberService < ApplicationCallable
      attr_reader :project, :properties

      def initialize(project, properties)
        @project      = project
        @properties   = properties
      end

      def call
        member = ::User.find(@properties[:member_id])

        @project.members << member

        { success: true, payload: @project }
      rescue ActiveRecord::RecordNotFound => _e
        { success: false, errors: 'user.notFound' }
      end
    end
  end
end
