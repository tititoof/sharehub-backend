# frozen_string_literal: true

module V1
  module Communications
    module Groups
      # Manage Conversations for a group
      # methods :
      #           - index - return group conversations
      #           - create - create a group conversation
      #           - update - update a group conversation
      #           - destroy - destroy a group conversation
      class ConversationsController < ApplicationController
        # force current_user to be authenticate
        before_action :authenticate_user!
        # find group before all actions
        before_action :set_group
        # find album for methods update & destroy
        before_action :set_conversation, only: %i[destroy]

        def index
          authorize [:v1, :communications, :conversations, @group]

          @resource = { success: true, payload: @group.conversations }

          serializer_response(::Communications::ConversationSerializer)
        end

        def create
          authorize [:v1, :communications, :conversations, @group]

          @resource = V1::Communications::Conversations::CreateProcedure.call(@group, conversation_params)

          serializer_response(::Communications::ConversationSerializer)
        end

        def destroy
          authorize [:v1, :communications, :conversations, @group]

          @resource = V1::Communications::Conversations::DestroyService.call(@converastion)

          object_response
        end

        private

        def set_group
          @group = ::Users::Group.find(params[:group_id])
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'group.notFound' }
        end

        def set_conversation
          @converastion = ::Communications::Conversation.find(params[:conversation_id])
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'conversation.notFound' }
        end

        def conversation_params
          params.required(:conversation).permit(:name)
        end
      end
    end
  end
end
