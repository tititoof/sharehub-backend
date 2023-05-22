# frozen_string_literal: true

module V1
  module Galleries
    module Media
      # Create a media of an album for albumable (User / Club / Sexshop) with the specified attributes.
      #
      # album - The User object for which to create an album.
      # properties - A Hash of attributes to set on the new album. The allowed keys are:
      #              - :medium - the name of the album.
      #              - :kind - the kind of the medium.
      #                 (image | video).
      #
      # Returns the newly created Album object if the record was saved successfully, or error if validation failed.
      class CreateService < ApplicationCallable
        attr_reader :album, :medium, :file

        def initialize(album, properties)
          @album  = album
          @medium = properties[:medium]
          @kind   = properties[:kind]
        end

        def call
          medium = ::Galleries::Medium.create!(album: @album, kind: @kind)

          medium.file.attach(@medium)

          { success: true, payload: medium }
        rescue ActiveRecord::RecordInvalid => e
          { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
        end
      end
    end
  end
end
