# frozen_string_literal: true

module V1
  module Users
    # Groups manamgement
    class GroupsController < ApplicationController
      # force current_user to be authenticate
      before_action :authenticate_user!
      # set organization for methods update & destroy
      before_action :set_group, only: %i[update destroy show add_member remove_member]

      # Return current_user's groups serialized
      def index
        authorize [:v1, ::Users::Group.all]

        @resource = V1::Users::Groups::ShowService.call(current_user)

        serializer_response(::Users::GroupSerializer)
      end

      # Return group serialized
      def show
        authorize [:v1, @group]

        @resource = { success: true, payload: @group }

        serializer_response(::Users::GroupSerializer)
      end

      # Create group and return it serialized
      def create
        authorize [:v1, ::Users::Group.all]

        @resource = V1::Users::Groups::CreateService.call(group_params)

        serializer_response(::Users::GroupSerializer)
      end

      # Update group and return it serialized
      def update
        authorize [:v1, @group]

        @resource = V1::Users::Groups::UpdateService.call(@group, group_params)

        serializer_response(::Users::GroupSerializer)
      end

      # Destroy group and return { done: :ok }
      def destroy
        authorize [:v1, @group]

        @resource = V1::Users::Groups::DestroyService.call(@group)

        object_response
      end

      # Return all groups
      def list
        authorize [:v1, ::Users::Group.all]

        @resource = { success: true, payload: ::Users::Group.all }

        serializer_response(::Users::GroupSerializer)
      end

      # Add member to a group
      def add_member
        authorize [:v1, @group]

        @resource = V1::Users::Groups::AddMemberService.call(@group, group_params)

        serializer_response(::Users::GroupSerializer)
      end

      # Remove member from a group
      def remove_member
        authorize [:v1, @group]

        @resource = V1::Users::Groups::AddMemberService.call(@group, group_params)

        serializer_response(::Users::GroupSerializer)
      end

      private

      def set_group
        @group = ::Users::Group.find(params[:group_id])
      rescue ActiveRecord::RecordNotFound => _e
        render json: { error: :recordNotFound }, status: :unprocessable_entity
      end

      def group_params
        params.required(:group).permit(:description, :kind, :name, :admin_id, :organization_id, :member_id)
      end
    end
  end
end
