require 'rails_helper'

RSpec.describe "V1::Organizations", type: :request do
  let (:admin) { create_admin }
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:organizations_url) { '/v1/organizations' }
  
  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns organizations serialized' do
        organization = FactoryBot.create(:organization)

        get organizations_url, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :activityDescription, 
                                                           :activitySector, :address, :annualTurnover,
                                                           :bornedAt, :emailAddress, :kind, 
                                                           :legalStatus, :name, :numberOfEmployees,
                                                           :phoneNumber, :registrationNumber, :website, 
                                                           :cityId, :countryId, :stateId).exactly
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # show
  # -------------------------------------------------------------------------------------
  describe "GET /:organization_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns organizations serialized' do
        organization = FactoryBot.create(:organization)

        get "#{organizations_url}/#{organization.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :activityDescription, 
                                                           :activitySector, :address, :annualTurnover,
                                                           :bornedAt, :emailAddress, :kind, 
                                                           :legalStatus, :name, :numberOfEmployees,
                                                           :phoneNumber, :registrationNumber, :website, 
                                                           :cityId, :countryId, :stateId).exactly
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns organizations serialized' do
        city = FactoryBot.create(:location_city)
        country = FactoryBot.create(:location_country)

        post "#{organizations_url}", params: {
          organization: { 
            activity_description: Faker::Books::Lovecraft.paragraph,
            activity_sector: 'agriculture_forestry',
            address: Faker::Address.full_address,
            annual_turnover: rand(100.0..5000.0),
            borned_at: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
            email_address: Faker::Internet.email,
            kind: 'sole_trader',
            legal_status: 'entreprise',
            name: Faker::Company.name,
            number_of_employees: rand(1..500),
            phone_number: Faker::PhoneNumber.phone_number_with_country_code,
            registration_number: Faker::Bank.account_number,
            website: Faker::Internet.url,
            city_id: city.id,
            country_id: country.id
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :activityDescription, 
                                                           :activitySector, :address, :annualTurnover,
                                                           :bornedAt, :emailAddress, :kind, 
                                                           :legalStatus, :name, :numberOfEmployees,
                                                           :phoneNumber, :registrationNumber, :website, 
                                                           :cityId, :countryId, :stateId).exactly
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # update
  # -------------------------------------------------------------------------------------
  describe "PUT /:organization_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns organizations serialized' do
        organization = FactoryBot.create(:organization)
        city = FactoryBot.create(:location_city)
        country = FactoryBot.create(:location_country)

        put "#{organizations_url}/#{organization.id}", params: {
          organization: { 
            activity_description: Faker::Books::Lovecraft.paragraph,
            activity_sector: 'agriculture_forestry',
            address: Faker::Address.full_address,
            annual_turnover: rand(100.0..5000.0),
            borned_at: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
            email_address: Faker::Internet.email,
            kind: 'sole_trader',
            legal_status: 'entreprise',
            name: Faker::Company.name,
            number_of_employees: rand(1..500),
            phone_number: Faker::PhoneNumber.phone_number_with_country_code,
            registration_number: Faker::Bank.account_number,
            website: Faker::Internet.url,
            city_id: city.id,
            country_id: country.id,
            admin_id: admin.id
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :activityDescription, 
                                                        :activitySector, :address, :annualTurnover,
                                                        :bornedAt, :emailAddress, :kind, 
                                                        :legalStatus, :name, :numberOfEmployees,
                                                        :phoneNumber, :registrationNumber, :website, 
                                                        :cityId, :countryId, :stateId).exactly
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # destroy
  # -------------------------------------------------------------------------------------
  describe "DELETE /:organization_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns organizations serialized' do
        organization = FactoryBot.create(:organization)

        delete "#{organizations_url}/#{organization.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['done']).to eq('ok')
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end

    # --------------------
    # User logged in & admin without organization
    # --------------------
    context 'when no organization' do
      before do
        login_with_api(admin)
      end

      it 'returns an error' do
        delete "#{organizations_url}/12345-4", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(response.status).to eq(422)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        get organizations_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # Add member
  # -------------------------------------------------------------------------------------
  describe "POST /add-member" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When admin' do
      before do
        login_with_api(admin)
      end

      it 'returns all groups serialized' do
        organization = FactoryBot.create(:organization)
        user  = FactoryBot.create(:user)

        post "#{organizations_url}/#{organization.id}/add-member",  params: {
          organization: { 
            member_id: user.id
          } }, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :activityDescription, 
                                                        :activitySector, :address, :annualTurnover,
                                                        :bornedAt, :emailAddress, :kind, 
                                                        :legalStatus, :name, :numberOfEmployees,
                                                        :phoneNumber, :registrationNumber, :website, 
                                                        :cityId, :countryId, :stateId).exactly
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        organization = FactoryBot.create(:organization)
        user  = FactoryBot.create(:user)

        post "#{organizations_url}/#{organization.id}/add-member",  params: {
          organization: { 
            member_id: user.id
          } 
        }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # Remove member
  # -------------------------------------------------------------------------------------
  describe "POST /remove-member" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When admin' do
      before do
        login_with_api(admin)
      end

      it 'returns all groups serialized' do
        organization = FactoryBot.create(:organization)
        user  = FactoryBot.create(:user)
        organization.users << user

        post "#{organizations_url}/#{organization.id}/remove-member",  params: {
          organization: { 
            member_id: user.id
          } }, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :activityDescription, 
                                                        :activitySector, :address, :annualTurnover,
                                                        :bornedAt, :emailAddress, :kind, 
                                                        :legalStatus, :name, :numberOfEmployees,
                                                        :phoneNumber, :registrationNumber, :website, 
                                                        :cityId, :countryId, :stateId).exactly
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        organization = FactoryBot.create(:organization)
        user  = FactoryBot.create(:user)
        organization.users << user

        post "#{organizations_url}/#{organization.id}/remove-member",  params: {
          organization: { 
            member_id: user.id
          } 
        }

        expect(response.status).to eq(401)
      end
    end
  end
end
