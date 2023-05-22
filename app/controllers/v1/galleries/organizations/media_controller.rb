# frozen_string_literal: true

module V1
  module Galleries
    module Organizations
      # Manage media for a organization's album
      # methods :
      #           - index - return album's media of a organization
      #           - create - create an album's media of a organization
      #           - update - update an album's media of a organization
      #           - destroy - destroy an album's media of a organization
      class MediaController < ApplicationController
        # force current_user to be authenticate
        before_action :authenticate_user!
        # find organization before all actions
        before_action :set_organization
        # find album for methods update & destroy
        before_action :set_album

        def index
          authorize [:v1, :galleries, :albums, @organization]

          @resource = { success: true, payload: @album.media }

          serializer_response(::Galleries::MediumSerializer)
        end

        def show
          authorize [:v1, :galleries, :albums, @organization]

          medium = ::Galleries::Medium.find(params[:medium_id])

          redirect_to rails_blob_url(medium.file)
        end

        def create
          authorize [:v1, :galleries, :albums, @organization]

          @resource = ::V1::Galleries::Media::CreateService.call(@album, medium_params)

          serializer_response(::Galleries::MediumSerializer)
        end

        def destroy
          authorize [:v1, :galleries, :albums, @organization]

          @resource = ::V1::Galleries::Media::DestroyService.call(params[:medium_id])

          object_response
        end

        private

        def set_organization
          @organization = ::Organization.find(params[:organization_id])
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'organization.notFound' }
        end

        def set_album
          @album = ::Galleries::Album.find(params[:album_id])
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'album.notFound' }
        end

        def medium_params
          params.required(:medium).permit(:medium, :kind)
        end
      end
    end
  end
end
