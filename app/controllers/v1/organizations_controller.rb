# frozen_string_literal: true

module V1
  # Manage current_user logged by jwt
  class OrganizationsController < ApplicationController
    # force current_user to be authenticate
    before_action :authenticate_user!
    # set organization for methods update & destroy
    before_action :set_organization, only: %i[update destroy show]

    def index
      authorize [:v1, ::Organization.all]

      @resource = { success: true, payload: ::Organization.all }

      serializer_response(::OrganizationSerializer)
    end

    def show
      authorize [:v1, @organization]

      @resource = { success: true, payload: @organization }

      serializer_response(::OrganizationSerializer)
    end

    def create
      authorize [:v1, ::Organization]

      @resource = V1::Organizations::CreateService.call(current_user, organization_params)

      serializer_response(::OrganizationSerializer)
    end

    def update
      authorize [:v1, @organization]

      @resource = V1::Organizations::UpdateService.call(@organization, current_user, organization_params)

      serializer_response(::OrganizationSerializer)
    end

    def destroy
      authorize [:v1, @organization]

      @resource = V1::Organizations::DestroyService.call(@organization)

      object_response
    end

    private

    def set_organization
      @organization = Organization.find(params[:organization_id])
    rescue ActiveRecord::RecordNotFound => _e
      render json: { error: :recordNotFound }, status: :unprocessable_entity
    end

    def organization_params
      params.required(:organization).permit(:activity_description, :activity_sector, :address,
                                            :annual_turnover, :borned_at, :email_address, :kind, :legal_status,
                                            :name, :number_of_employees, :phone_number, :registration_number,
                                            :website, :city_id, :country_id)
    end
  end
end
