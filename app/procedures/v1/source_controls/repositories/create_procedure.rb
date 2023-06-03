# frozen_string_literal: true

module V1
  module SourceControls
    module Repositories
      class CreateProcedure < ApplicationCallable
        attr_reader :project, :properties

        def initialize(project, properties)
          @project    = project
          @properties = properties
        end

        def call
          resource = ::V1::SourceControls::Repositories::CreateService.call(@project,
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
