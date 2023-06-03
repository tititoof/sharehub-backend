# frozen_string_literal: true

module V1
  module SourceControls
    module Repositories
      # Update a repository with the specified properties.
      #
      # project - The project to update in repository
      # repository - The repository to update
      # sourcable - The source_controls type (Gitea / Forgejo / Github / Gitlab / ...)
      # properties - A Hash of attributes to set on the new conversation. The allowed keys are:
      #               - name - name of the repository
      #               - owner - owner of the repository
      #               - repo - identifiant of the repository
      #
      # Returns the newly updated Reposiroty object if the record was saved successfully,
      # or error if validation failed.
      class UpdateService < ApplicationCallable
        attr_reader :project, :repository, :sourcable, :properties

        def initialize(project, repository, sourcable, properties)
          @projet     = project
          @repository = repository
          @sourcable  = sourcable
          @properties = properties
        end

        def call
          @repository.update!(name: @properties[:name],
                              owner: @properties[:owner],
                              repo: @properties[:repo],
                              project: @projet,
                              sourcable: @sourcable)

          { success: true, payload: @repository }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
