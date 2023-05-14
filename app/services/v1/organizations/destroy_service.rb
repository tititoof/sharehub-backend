# frozen_string_literal: true

module V1
  module Organizations
    # Destroy an organization.
    #
    # organization - The organization object to destroy
    #
    # Returns the :ok status if the record was destroyed successfully, or error if validation failed.
    class DestroyService < ApplicationCallable
      attr_reader :organization, :user, :properties

      def initialize(organization)
        @organization = organization
      end

      def call
        @organization.destroy!

        { success: true, payload: { done: :ok } }
      end
    end
  end
end
