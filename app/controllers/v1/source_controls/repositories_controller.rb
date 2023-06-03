# frozen_string_literal: true

module V1
  module SourceControls
    # Manage repositories for a project
    class RepositoriesController < ApplicationController
      # force current_user to be authenticate
      before_action :authenticate_user!
      # find project before actions
      before_action :set_project
      # find repository before actions
      before_action :set_repository, only: %i[show update destroy]

      def index
        @resource = { success: true, payload: @project.source_control_repositories }

        serializer_response(::SourceControls::RepositorySerializer)
      end

      def show
        @resource = { success: true, payload: @repository }

        serializer_response(::SourceControls::RepositorySerializer)
      end

      def create
        @resource = V1::SourceControls::Repositories::CreateProcedure.call(@project, repository_params)

        serializer_response(::SourceControls::RepositorySerializer)
      end

      def update
        @resource = V1::SourceControls::Repositories::UpdateProcedure.call(@project, @repository, repository_params)

        serializer_response(::SourceControls::RepositorySerializer)
      end

      def destroy
        @resource = V1::SourceControls::Repositories::DestroyService.call(@repository)

        object_response
      end

      private

      def set_project
        @project = Project.find(params[:project_id])
      rescue ActiveRecord::RecordNotFound => _e
        { success: false, errors: 'project.notFound' }
      end

      def set_repository
        @repository = ::SourceControls::Repository.find(params[:repository_id])
      rescue ActiveRecord::RecordNotFound => _e
        { success: false, errors: 'repository.notFound' }
      end

      def repository_params
        params.required(:repository).permit(:name, :owner, :repo, :sourcable_type, :project_id, :sourcable_id)
      end
    end
  end
end
