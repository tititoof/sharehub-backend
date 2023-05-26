# frozen_string_literal: true

module V1
  module Communications
    module Groups
      # Authorize Conversation access for the current user
      class ConversationPolicy < ApplicationPolicy
        def index?
          @user.is_admin? || @record.users.include?(@user)
        end

        def create?
          @user.is_admin? || @record.admins.include?(@user)
        end

        def update?
          @user.is_admin? || @record.admins.include?(@user)
        end

        def destroy?
          @user.is_admin? || @record.admins.include?(@user)
        end
      end
    end
  end
end
