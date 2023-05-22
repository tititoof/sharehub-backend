# frozen_string_literal: true

module V1
  module Galleries
    module Media
      # Create a media of an album for albumable (User / Club / Sexshop) with the specified attributes.
      #
      # album - The User object for which to create an album.
      # options - A Hash of attributes to set on the new album. The allowed keys are:
      #              - :medium - the name of the album.
      #              - :kind - the kind of the medium.
      #                 (image | video).
      #
      # Returns the newly created Album object if the record was saved successfully, or error if validation failed.
      class DestroyService < ApplicationCallable
        attr_reader :medium_id

        def initialize(medium_id)
          @medium_id = medium_id
        end

        def call
          medium = ::Galleries::Medium.find(medium_id)

          medium.file.purge

          medium.delete

          { success: true, payload: { done: :ok } }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
