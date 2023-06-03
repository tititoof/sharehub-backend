# frozen_string_literal: true

module V1
  module SourceControls
    module Repositories
      class UpdateProcedure < ApplicationCallable
        attr_reader :project, :repository, :properties

        def initialize(project, repository, properties)
          @project    = project
          @repository = repository
          @properties = properties
        end

        def call
          resource = ::V1::SourceControls::Repositories::UpdateService.call(@project,
                                                                            @repository,
                                                                            set_sourcable_type,
                                                                            @properties)

          { success: true, payload: resource[:payload] }
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'repository.notFound' }
        end

        def set_sourcable_type
          if @properties[:sourcable_type] == 'Gitea'
            ::SourceControls::Gitea.find(@properties[:sourcable_id])
          end
        end
      end
    end
  end
end
