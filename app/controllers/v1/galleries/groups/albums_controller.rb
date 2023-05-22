# frozen_string_literal: true

module V1
  module Galleries
    module Groups
      # Manage albums for a group
      # methods :
      #           - index - return group albums
      #           - create - create a group album
      #           - update - update a group album
      #           - destroy - destroy a group album
      class AlbumsController < ApplicationController
        # force current_user to be authenticate
        before_action :authenticate_user!
        # find group before all actions
        before_action :set_group
        # find album for methods update & destroy
        before_action :set_album, only: %i[show update destroy]

        def index
          authorize [:v1, :galleries, :albums, @group]

          @resource = { success: true, payload: @group.albums }

          serializer_response(::Galleries::AlbumSerializer)
        end

        def show
          authorize [:v1, :galleries, :albums, @group]

          @resource = { success: true, payload: @album }

          serializer_response(::Galleries::AlbumSerializer)
        end

        def create
          authorize [:v1, :galleries, :albums, @group]

          @resource = ::V1::Galleries::Albums::CreateService.call(@group, album_params)

          serializer_response(::Galleries::AlbumSerializer)
        end

        def update
          authorize [:v1, :galleries, :albums, @group]

          @resource = ::V1::Galleries::Albums::UpdateService.call(@album, album_params)

          serializer_response(::Galleries::AlbumSerializer)
        end

        def destroy
          authorize [:v1, :galleries, :albums, @group]

          @resource = ::V1::Galleries::Albums::DestroyService.call(@album)

          object_response
        end

        private

        def set_group
          @group = ::Users::Group.find(params[:group_id])
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'group.notFound' }
        end

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
