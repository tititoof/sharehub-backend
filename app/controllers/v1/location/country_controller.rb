# frozen_string_literal: true

module V1
  module Location
    # Manage current_user logged by jwt
    class CountryController < ApplicationController
      # force current_user to be authenticate
      before_action :authenticate_user!

      # return current_user serialized
      def index
        @resource = { success: true, payload: ::Location::Country.all }

        serializer_response(::Location::CountrySerializer)
      end
    end
  end
end
