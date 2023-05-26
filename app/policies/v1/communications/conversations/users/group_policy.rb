# frozen_string_literal: true

module V1
  module Communications
    module Conversations
      module Users
        # Authorize Conversation access for the current user
        class GroupPolicy < ApplicationPolicy
          def index?
            @user.is_admin? || @record.users.include?(@user)
          end

          def create?
            @user.is_admin? || @record.admin == @user
          end

          def update?
            @user.is_admin? || @record.admin == @user
          end

          def destroy?
            @user.is_admin? || @record.admin == @user
          end
        end
      end
    end
  end
end
