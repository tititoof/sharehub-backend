# frozen_string_literal: true

module V1
  module SourceControls
    module Giteas
      # Destroy a gitea server.
      #
      # gitea - The gitea to destroy
      #
      # Returns an object with done : ok if the record was destroy successfully,
      # or error if not found.
      class DestroyService < ApplicationCallable
        attr_reader :gitea

        def initialize(gitea)
          @gitea = gitea
        end

        def call
          @gitea.destroy!

          { success: true, payload: { done: :ok } }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
