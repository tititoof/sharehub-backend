# frozen_string_literal: true

module V1
  module Communications
    module Users
      # Manage Messages for a group
      # methods :
      #           - index - return group conversations
      #           - create - create a group conversation
      class MessagesController < ApplicationController
        # force current_user to be authenticate
        before_action :authenticate_user!
        # find album for methods update & destroy
        before_action :set_conversation

        def index
          authorize [:v1, @conversation]

          @resource = { success: true, payload: @conversation.messages }

          serializer_response(::Communications::MessageSerializer)
        end

        def create
          authorize [:v1, @conversation]

          @resource = V1::Communications::Messages::CreateService.call(@conversation, current_user, message_params)

          serializer_response(::Communications::MessageSerializer)
        end

        private

        def set_conversation
          @conversation = ::Communications::Conversation.find(params[:conversation_id])
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'conversation.notFound' }
        end

        def message_params
          params.required(:message).permit(:content, :medium)
        end
      end
    end
  end
end
