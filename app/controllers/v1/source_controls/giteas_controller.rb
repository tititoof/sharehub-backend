# frozen_string_literal: true

module V1
  module SourceControls
    # Manage Giteas source controls
    class GiteasController < ApplicationController
      # force current_user to be authenticate
      before_action :authenticate_user!
      # find organization before all actions
      before_action :set_organization
      # find gitea before actions
      before_action :set_gitea, only: %i[show update destroy]

      def index
        authorize [:v1, @organization]

        @resource = { success: true, payload: ::SourceControls::Gitea.all }

        serializer_response(::SourceControls::GiteaSerializer)
      end

      def show
        authorize [:v1, @organization]

        @resource = { success: true, payload: @gitea }

        serializer_response(::SourceControls::GiteaSerializer)
      end

      def create
        authorize [:v1, @organization]

        @resource = V1::SourceControls::Giteas::CreateService.call(@organization, gitea_params)

        serializer_response(::SourceControls::GiteaSerializer)
      end

      def update
        authorize [:v1, @organization]

        @resource = V1::SourceControls::Giteas::UpdateService.call(@gitea, gitea_params)

        serializer_response(::SourceControls::GiteaSerializer)
      end

      def destroy
        authorize [:v1, @organization]

        @resource = V1::SourceControls::Giteas::DestroyService.call(@gitea)

        object_response
      end

      private

      def set_gitea
        @gitea = ::SourceControls::Gitea.find(params[:gitea_id])
      rescue ActiveRecord::RecordNotFound => _e
        { success: false, errors: 'gitea.notFound' }
      end

      def set_organization
        @organization = Organization.find(params[:organization_id])
      rescue ActiveRecord::RecordNotFound => _e
        { success: false, errors: 'organization.notFound' }
      end

      def gitea_params
        params.required(:gitea).permit(:access_token, :api_url, :ip_address, :port, :name)
      end
    end
  end
end
