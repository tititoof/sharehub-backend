# frozen_string_literal: true

module V1
  module Projects
    # Create a project with the specified properties.
    #
    # organization - the organization of the project
    # properties - A Hash of attributes to set on the new project. The allowed keys are:
    #             - title - The title of the project
    #             - description - The description
    #             - start_at - start date
    #             - end_at - end date
    #             - status - the status of the project
    #             - manager - the manager's user
    #             - external_references -
    #             - category - the category of the project
    #
    # Returns the newly created Project object if the record was saved successfully,
    # or error if validation failed.
    class CreateService < ApplicationCallable
      attr_reader :organization, :properties

      def initialize(organization, properties)
        @organization = organization
        @properties   = properties
      end

      def call
        manager = ::User.find(@properties[:manager])

        project = ::Project.create!(title: @properties[:title], description: @properties[:description],
                                    start_at: @properties[:start_at], end_at: @properties[:end_at],
                                    status: @properties[:status], manager:,
                                    external_references: @properties[:external_references],
                                    category: @properties[:category],
                                    organization: @organization)

        { success: true, payload: project }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
      end
    end
  end
end
