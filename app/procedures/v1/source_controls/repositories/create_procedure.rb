# frozen_string_literal: true

module V1
  module SourceControls
    module Repositories
      # Create a repository with the specified properties.
      #
      # project - The project to add in repository
      # properties - A Hash of attributes to set on the new conversation. The allowed keys are:
      #               - name - name of the repository
      #               - owner - owner of the repository
      #               - repo - identifiant of the repository
      #               - sourcable_type - source_controls type (Gitea / Forgejo / Github / Gitlab / ...)
      #               - sourcable_id - the id of the source_controls
      #
      # Returns the newly created Reposiroty object if the record was saved successfully,
      # or error if validation failed.
      class CreateProcedure < ApplicationCallable
        attr_reader :project, :properties

        def initialize(project, properties)
          @project    = project
          @properties = properties
        end

        def call
          sourcable = ::V1::SourceControls::Repositories::SetSourcableService.call(@properties[:sourcable_type],
                                                                                   @properties[:sourcable_id])
          resource  = ::V1::SourceControls::Repositories::CreateService.call(@project, sourcable,
                                                                             @properties)

          { success: true, payload: resource[:payload] }
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'repository.notFound' }
        rescue ArgumentError => e
          { success: false, errors: e.message, status: :unprocessable_entity }
        end
      end
    end
  end
end
