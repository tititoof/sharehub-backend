# frozen_string_literal: true

module V1
  # Authorize project access for the current user
  class ProjectPolicy < ApplicationPolicy
    def index?
      @user.is_admin? || @record.members.include?(@user)
    end

    def show?
      @user.is_admin? || @record.members.include?(@user)
    end

    def update?
      @user.is_admin? || @record.manager == @user
    end

    def create?
      @user.is_admin? || @record.manager == @user
    end

    def destroy?
      @user.is_admin? || @record.manager == @user
    end

    def add_member?
      @user.is_admin? || @record.manager == @user
    end

    def remove_member?
      @user.is_admin? || @record.manager == @user
    end
  end
end
