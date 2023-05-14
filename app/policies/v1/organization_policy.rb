# frozen_string_literal: true

module V1
  # Authorize organization access for the current user
  class OrganizationPolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      @user.is_admin?
    end

    def update?
      @user.is_admin?
    end

    def create?
      @user.is_admin?
    end

    def destroy?
      @user.is_admin?
    end
  end
end
