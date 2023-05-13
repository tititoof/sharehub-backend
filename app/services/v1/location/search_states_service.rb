# frozen_string_literal: true

module V1
  module Location
    # Searching states based on a given country ID.
    #
    # country_id - The country ID .
    #
    # Returns the states collection.
    class SearchStatesService < ApplicationCallable
      attr_reader :country_id

      def initialize(country_id)
        @country_id = country_id
      end

      def call
        country = ::Location::Country.find(country_id)
        states  = ::Location::State.where(country:)

        { success: true, payload: states }
      end
    end
  end
end
