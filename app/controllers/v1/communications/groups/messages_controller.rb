# frozen_string_literal: true

module V1
  module Communications
    module Groups
      # Manage Messages for a group
      # methods :
      #           - index - return group conversations
      #           - create - create a group conversation
      class MessagesController < ApplicationController
        # force current_user to be authenticate
        before_action :authenticate_user!
        # find group before all actions
        before_action :set_group
        # find album for methods update & destroy
        before_action :set_conversation

        def index
          authorize [:v1, :communications, :conversations, @group]

          @resource = { success: true, payload: @conversation.messages }

          serializer_response(::Communications::MessageSerializer)
        end

        def create
          authorize [:v1, :communications, :conversations, @group]

          @resource = V1::Communications::Messages::CreateService.call(@conversation, current_user, message_params)

          serializer_response(::Communications::MessageSerializer)
        end

        private

        def set_group
          @group = ::Users::Group.find(params[:group_id])
        rescue ActiveRecord::RecordNotFound => _e
          { success: false, errors: 'group.notFound' }
        end

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
