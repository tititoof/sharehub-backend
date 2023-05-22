# frozen_string_literal: true

module V1
  module Galleries
    module Users
      # Manage albums for an organization
      # methods :
      #           - index - return organization albums
      #           - create - create an organization album
      #           - update - update an organization album
      #           - destroy - destroy an organization album
      class AlbumsController < ApplicationController
        # force current_user to be authenticate
        before_action :authenticate_user!
        # find album for methods update & destroy
        before_action :set_album, only: %i[show update destroy]

        def index
          authorize [:v1, ::Galleries::Album]

          @resource = { success: true, payload: current_user.albums }

          serializer_response(::Galleries::AlbumSerializer)
        end

        def show
          authorize [:v1, @album]

          @resource = { success: true, payload: @album }

          serializer_response(::Galleries::AlbumSerializer)
        end

        def create
          authorize [:v1, ::Galleries::Album]

          @resource = ::V1::Galleries::Albums::CreateService.call(current_user, album_params)

          serializer_response(::Galleries::AlbumSerializer)
        end

        def update
          authorize [:v1, @album]

          @resource = ::V1::Galleries::Albums::UpdateService.call(@album, album_params)

          serializer_response(::Galleries::AlbumSerializer)
        end

        def destroy
          authorize [:v1, @album]

          @resource = ::V1::Galleries::Albums::DestroyService.call(@album)

          object_response
        end

        private

        def set_album
          @album = ::Galleries::Album.find(params[:album_id])
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'album.notFound' }
        end

        def album_params
          params.required(:album).permit(:title, :aasm_state, :description)
        end
      end
    end
  end
end
