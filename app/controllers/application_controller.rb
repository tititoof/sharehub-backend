# frozen_string_literal: true

# The base controller for API endpoints.
# All API controllers should inherit from this controller.
class ApplicationController < ActionController::API
  # Authorization
  include Pundit::Authorization

  # Include the ApiResponder module for JSON responses
  include ApiResponder

  # Pundit authorize
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized_user

  # Use JSON as the default response format
  respond_to :json

  private

  def not_authorized_user
    @resource = { success: false, error: { data: { user: 'notAuthorized' } } }

    object_response
  end
end
