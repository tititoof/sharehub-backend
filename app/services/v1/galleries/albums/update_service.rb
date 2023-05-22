# frozen_string_literal: true

module V1
  module Galleries
    module Albums
      # Update an album for albumable (User | Organization | Group) with the specified attributes.
      #
      # album_id - The User object for which to create an album.
      # properties - A Hash of attributes to set on the new album. The allowed keys are:
      #              - :title - the name of the album.
      #              - :aasm_state - the state of the album.
      #                 (draft | private_published | friend_published | public_published).
      #
      # Returns the newly updated Album object if the record was saved successfully, or error if validation failed or
      # album.notFound if not found.
      class UpdateService < ApplicationCallable
        attr_reader :album, :properties

        def initialize(album, properties)
          @album      = album
          @properties = properties
        end

        def call
          @album.update!(title: @properties[:title], description: @properties[:description])

          change_state

          { success: true, payload: @album }
        end

        def change_state
          case @properties[:aasm_state]
          when 'draft_publish'
            @album.draft_publish!
          when 'private_publish'
            @album.private_publish!
          when 'friend_publish'
            @album.friend_publish!
          when 'public_publish'
            @album.public_publish!
          else
            @album.draft_publish!
          end
        end
      end
    end
  end
end
