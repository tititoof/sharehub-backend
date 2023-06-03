# frozen_string_literal: true

module V1
  module Projects
    # Update a project with the specified properties.
    #
    # project - the project to update
    # properties - A Hash of attributes to set on the project. The allowed keys are:
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
    class UpdateService < ApplicationCallable
      attr_reader :project, :properties

      def initialize(project, properties)
        @project    = project
        @properties = properties
      end

      def call
        manager = ::User.find(@properties[:manager])

        @project.update!(title: @properties[:title], description: @properties[:description],
                         start_at: @properties[:start_at], end_at: @properties[:end_at],
                         status: @properties[:status], manager:,
                         external_references: @properties[:external_references],
                         category: @properties[:category])

        { success: true, payload: @project }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
      end
    end
  end
end
