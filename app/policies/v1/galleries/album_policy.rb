# frozen_string_literal: true

module V1
  module Galleries
    # Authorize album access for the current user
    class AlbumPolicy < ApplicationPolicy
      def index?
        true
      end

      def show?
        @user == @record.albumable
      end

      # Only admin is allowed to update the article and only if article is not published
      def update?
        @user == @record.albumable
      end

      # Only admin is allowed to create the article.
      def create?
        true
      end

      def destroy?
        @user == @record.albumable
      end
    end
  end
end
