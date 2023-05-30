# frozen_string_literal: true

module V1
  module Projects
    # Destroy a project.
    #
    # project - The project to destroy
    #
    # Returns an object with done : ok if the record was destroy successfully,
    # or error if not found.
    class DestroyService < ApplicationCallable
      attr_reader :project

      def initialize(project)
        @project = project
      end

      def call
        @project.destroy!

        { success: true, payload: { done: :ok } }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
      end
    end
  end
end
