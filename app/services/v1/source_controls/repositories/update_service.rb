# frozen_string_literal: true

module V1
  module SourceControls
    module Repositories
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
