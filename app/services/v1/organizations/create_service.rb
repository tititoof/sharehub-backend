# frozen_string_literal: true

module V1
  module Organizations
    # Create an organization with the specified attributes.
    #
    # user - The User object for which to create an organization.
    # properties - A Hash of attributes to set on the new organization. The allowed keys are:
    #       - activity_description : a little text to describe the organization (required )
    #       - activity_sector : key of Organization::activity_sector_options.
    #       - address : Address text without city.
    #       - annual_turnover : The annual turnover of the organization.
    #       - borned_at : The date of birth or founding of the organization.
    #       - email_address : The email address of the organization.
    #       - kind :  The type of organization  in Orgzanization::kind_options.
    #       - legal_status : The legal status of the organization in Orgzanization::legal_status_options.
    #       - name : The name of the organization.
    #       - number_of_employees : The number of employees in the organization.
    #       - phone_number : The phone number of the organization.
    #       - registration_number : The registration number of the organization.
    #       - website : The website of the organization.
    #       - city_id : The ID of the city where the organization is located.
    #       - country_id : The ID of the country where the organization is located
    #
    # Returns the newly created Organization object if the record was saved successfully, or error if validation failed.
    class CreateService < ApplicationCallable
      attr_reader :user, :properties

      def initialize(user, properties)
        @user       = user
        @properties = properties
      end

      def call
        city         = ::Location::City.find(@properties[:city_id])
        country      = ::Location::Country.find(@properties[:country_id])

        organization = create(city, country)

        { success: true, payload: organization }
      rescue ActiveRecord::RecordInvalid => e
        { success: false, errors: e.record.errors.as_json, status: :unprocessable_entity }
      end

      def create(city, country)
        Organization.create!(activity_description: @properties[:activity_description],
                             activity_sector: @properties[:activity_sector],
                             address: @properties[:address], borned_at: @properties[:borned_at],
                             annual_turnover: @properties[:annual_turnover],
                             email_address: @properties[:email_address],
                             kind: @properties[:kind], legal_status: @properties[:legal_status],
                             name: @properties[:name], number_of_employees: @properties[:number_of_employees],
                             phone_number: @properties[:phone_number], region: @properties[:region],
                             registration_number: @properties[:registration_number],
                             website: @properties[:website], city:, country:, admin: @user)
      end
    end
  end
end
