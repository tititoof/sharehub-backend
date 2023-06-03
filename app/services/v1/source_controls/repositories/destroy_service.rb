# frozen_string_literal: true

module V1
  module SourceControls
    module Repositories
      class DestroyService < ApplicationCallable
        attr_reader :repository

        def initialize(repository)
          @repository = repository
        end

        def call
          @repository.destroy!

          { success: true, payload: { done: :ok } }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
