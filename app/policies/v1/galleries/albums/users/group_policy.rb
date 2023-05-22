# frozen_string_literal: true

module V1
  module Galleries
    module Albums
      module Users
        # Authorize Album access for the current user
        class GroupPolicy < ApplicationPolicy
          def index?
            @user.is_admin? || @record.users.include?(@user)
          end

          def show?
            @user.is_admin? || @record.users.include?(@user)
          end

          def create?
            @user.is_admin? || @record.users.include?(@user)
          end

          def update?
            @user.is_admin? || @record.users.include?(@user)
          end

          def destroy?
            @user.is_admin? || @record.admin == @user
          end
        end
      end
    end
  end
end
