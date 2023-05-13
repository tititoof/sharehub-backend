# frozen_string_literal: true

module V1
  module Location
    # Searching cities based on a given state ID.
    #
    # state_id - The state ID .
    #
    # Returns the cities collection.
    class SearchCitiesService < ApplicationCallable
      attr_reader :state_id

      def initialize(state_id)
        @state_id = state_id
      end

      def call
        state = ::Location::State.find(state_id)
        cities = ::Location::City.where(state:)

        { success: true, payload: cities }
      end
    end
  end
end
