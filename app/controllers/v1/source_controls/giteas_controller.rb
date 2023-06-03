# frozen_string_literal: true

module V1
  module SourceControls
    # Manage Giteas source controls
    class GiteasController < ApplicationController
      # force current_user to be authenticate
      before_action :authenticate_user!
      # find gitea before actions
      before_action :set_gitea, only: %i[show update destroy]

      def index
        @resource = { success: true, payload: ::SourceControls::Gitea.all }

        serializer_response(::SourceControls::GiteaSerializer)
      end

      def show
        @resource = { success: true, payload: @gitea }

        serializer_response(::SourceControls::GiteaSerializer)
      end

      def create
        @resource = V1::SourceControls::Giteas::CreateService.call(gitea_params)

        serializer_response(::SourceControls::GiteaSerializer)
      end

      def update
        @resource = V1::SourceControls::Giteas::UpdateService.call(@gitea, gitea_params)

        serializer_response(::SourceControls::GiteaSerializer)
      end

      def destroy
        @resource = V1::SourceControls::Giteas::DestroyService.call(@gitea)

        object_response
      end

      private

      def set_gitea
        @gitea = ::SourceControls::Gitea.find(params[:gitea_id])
      rescue ActiveRecord::RecordNotFound => _e
        { success: false, errors: 'gitea.notFound' }
      end

      def gitea_params
        params.required(:gitea).permit(:access_token, :api_url, :ip_address, :port)
      end
    end
  end
end
