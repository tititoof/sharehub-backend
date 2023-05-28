# frozen_string_literal: true

module V1
  module Communications
    module Messages
      module Users
        # Authorize Conversation access for the current user
        class GroupPolicy < ApplicationPolicy
          def index?
            @user.is_admin? || @record.users.include?(@user)
          end

          def create?
            @user.is_admin? || @record.users.include?(@user)
          end
        end
      end
    end
  end
end
