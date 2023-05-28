# frozen_string_literal: true

module V1
  module Communications
    module Users
      # Manage Conversations for a group
      # methods :
      #           - index - return group conversations
      #           - create - create a group conversation
      #           - update - update a group conversation
      #           - destroy - destroy a group conversation
      class ConversationsController < ApplicationController
        # force current_user to be authenticate
        before_action :authenticate_user!
        # find album for methods update & destroy
        before_action :set_conversation, only: %i[destroy update]

        def index
          authorize [:v1, current_user.conversations]

          @resource = { success: true, payload: current_user.conversations }

          serializer_response(::Communications::ConversationSerializer)
        end

        def create
          authorize [:v1, ::Communications::Conversation]

          @resource = V1::Communications::Conversations::CreateProcedure.call(current_user, conversation_params)

          serializer_response(::Communications::ConversationSerializer)
        end

        def update
          authorize [:v1, @conversation]

          @resource = V1::Communications::Conversations::UpdateService.call(@conversation, conversation_params)

          serializer_response(::Communications::ConversationSerializer)
        end

        def destroy
          authorize [:v1, @conversation]

          @resource = V1::Communications::Conversations::DestroyService.call(@conversation)

          object_response
        end

        private

        def set_conversation
          @conversation = ::Communications::Conversation.find(params[:conversation_id])
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
