# frozen_string_literal: true

module V1
  module Galleries
    module Albums
      # Create an album for albumable (User | Organization | Group) with the specified properties.
      #
      # albumable - The User object for which to create an album.
      # properties - A Hash of attributes to set on the new album. The allowed keys are:
      #              - :title - the name of the album.
      #              - :aasm_state - the state of the album.
      #                 (draft | private_published | friend_published | public_published).
      #
      # Returns the newly created Album object if the record was saved successfully, or error if validation failed.
      class CreateService < ApplicationCallable
        attr_reader :albumable, :properties

        def initialize(albumable, properties)
          @albumable  = albumable
          @properties = properties
        end

        def call
          album = ::Galleries::Album.create!(albumable: @albumable, title: @properties[:title],
                                             description: @properties[:description],
                                             aasm_state: @properties[:aasm_state])

          { success: true, payload: album }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
