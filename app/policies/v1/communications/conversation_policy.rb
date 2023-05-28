# frozen_string_literal: true

module V1
  module Communications
    # Authorize Conversation access for the current user
    class ConversationPolicy < ApplicationPolicy
      def index?
        true
      end

      def create?
        true
      end

      def update?
        @record.users.include?(@user)
      end

      def destroy?
        @user.is_admin?
      end
    end
  end
end
