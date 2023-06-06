# frozen_string_literal: true

module V1
  # Manage current_user logged by jwt
  class ProjectsController < ApplicationController
    # force current_user to be authenticate
    before_action :authenticate_user!
    # find organization before all actions
    before_action :set_organization
    # find project before actions
    before_action :set_project, only: %i[show update destroy add_member remove_member]

    # return current_user serialized
    def index
      authorize [:v1, @organization]

      @resource = { success: true, payload: @organization.projects }

      serializer_response(::ProjectSerializer)
    end

    def show
      authorize [:v1, @organization]

      @resource = { success: true, payload: @project }

      serializer_response(::ProjectSerializer)
    end

    def create
      authorize [:v1, @organization]

      @resource = ::V1::Projects::CreateService.call(@organization, project_params)

      serializer_response(::ProjectSerializer)
    end

    def update
      authorize [:v1, @organization]

      @resource = ::V1::Projects::UpdateService.call(@project, project_params)

      serializer_response(::ProjectSerializer)
    end

    def destroy
      authorize [:v1, @organization]

      @resource = ::V1::Projects::DestroyService.call(@project)

      object_response
    end

    # Add member to a project
    def add_member
      authorize [:v1, @organization]

      @resource = V1::Projects::AddMemberService.call(@project, project_params)

      serializer_response(::ProjectSerializer)
    end

    # Remove member from a project
    def remove_member
      authorize [:v1, @organization]

      @resource = V1::Projects::RemoveMemberService.call(@project, project_params)

      serializer_response(::ProjectSerializer)
    end

    private

    def set_project
      @project = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound => _e
      { success: false, errors: 'project.notFound' }
    end

    def set_organization
      @organization = Organization.find(params[:organization_id])
    rescue ActiveRecord::RecordNotFound => _e
      { success: false, errors: 'organization.notFound' }
    end

    def project_params
      params.required(:project).permit(:title, :description, :start_at, :end_at, :status, :manager,
                                       :external_references, :category, :member_id)
    end
  end
end
