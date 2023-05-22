# frozen_string_literal: true

module V1
  module Galleries
    module Albums
      # Destroy an album for albumable (User | Organization | Group) with the specified attributes.
      #
      # album - The Album object to destroy.
      #
      # Returns an object with done : ok if the record was destroy successfully, or error if not found.
      class DestroyService < ApplicationCallable
        attr_reader :album

        def initialize(album)
          @album = album
        end

        def call
          @album.destroy!

          { success: true, payload: { done: :ok } }
        end
      end
    end
  end
end
