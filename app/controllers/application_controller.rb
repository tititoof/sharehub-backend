# frozen_string_literal: true

# The base controller for API endpoints.
# All API controllers should inherit from this controller.
class ApplicationController < ActionController::API
  # Include the ApiResponder module for JSON responses
  include ApiResponder

  # Use JSON as the default response format
  respond_to :json
end
