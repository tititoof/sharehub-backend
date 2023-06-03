# frozen_string_literal: true

module V1
  module SourceControls
    module Repositories
      # Find a source control with the specified properties.
      #
      # sourcable_type - The sourcable type
      # sourcable_id - The sourcable id
      #
      # Returns the Source control (Gitea / Gitlab / Github/ ...) object if the record was found successfully
      class SetSourcableService < ApplicationCallable
        attr_reader :sourcable_type, :sourcable_id

        def initialize(sourcable_type, sourcable_id)
          @sourcable_type = sourcable_type
          @sourcable_id   = sourcable_id
        end

        def call
          case @sourcable_type
          when 'Gitea' then ::SourceControls::Gitea.find(@sourcable_id)
          else              raise ArgumentError, 'repository.notFound'
          end
        end
      end
    end
  end
end
