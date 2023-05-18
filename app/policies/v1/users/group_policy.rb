# frozen_string_literal: true

module V1
  module Users
    # Authorize group access for the current user
    class GroupPolicy < ApplicationPolicy
      def index?
        true
      end

      def show?
        @user.is_admin? || @record.users.include?(@user)
      end

      def create?
        @user.is_admin?
      end

      def update?
        @user.is_admin? || @record.admin == @user
      end

      def destroy?
        @user.is_admin? || @record.admin == @user
      end

      def list?
        @user.is_admin?
      end
    end
  end
end
