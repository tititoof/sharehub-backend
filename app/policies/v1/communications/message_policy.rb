# frozen_string_literal: true

module V1
  module Communications
    # Authorize Message access for the current user
    class MessagePolicy < ApplicationPolicy
      def index?
        @record.conversation.users.include?(@user)
      end

      def create?
        @record.conversation.users.include?(@user)
      end
    end
  end
end
