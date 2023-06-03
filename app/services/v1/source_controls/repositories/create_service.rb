# frozen_string_literal: true

module V1
  module SourceControls
    module Repositories
      class CreateService < ApplicationCallable
        attr_reader :project, :sourcable, :properties

        def initialize(project, sourcable, properties)
          @projet     = project
          @sourcable  = sourcable
          @properties = properties
        end

        def call
          repository = ::SourceControls::Repository.create!(name: @properties[:name],
                                                            owner: @properties[:owner],
                                                            repo: @properties[:repo],
                                                            project: @projet,
                                                            sourcable: @sourcable)

          { success: true, payload: repository }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
