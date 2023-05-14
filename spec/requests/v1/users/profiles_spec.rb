require 'rails_helper'

RSpec.describe "V1::Users::Profiles", type: :request do
  let (:admin) { create_admin }
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:profiles_url) { '/v1/users/profiles' }

  # ------------------
  # index
  # ------------------
  describe "GET /" do
    # User logged & admin
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns organizations serialized' do
        profile = FactoryBot.create(:users_profile, user: user)

        get profiles_url, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :address, :dateOfBirth, :email, 
                                                        :firstName, :lastName, :nickname, :phone, 
                                                        :cityId, :userId).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        get profiles_url

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # show
  # ------------------
  describe "GET /:profile_id" do
    # User logged & admin
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns organizations serialized' do
        profile = FactoryBot.create(:users_profile, user:)

        get "#{profiles_url}/#{profile.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :address, :dateOfBirth, :email, 
                                                        :firstName, :lastName, :nickname, :phone, 
                                                        :cityId, :userId).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        get profiles_url

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # list
  # ------------------
  describe "GET /list" do
    # User logged & admin
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns organizations serialized' do
        profile = FactoryBot.create(:users_profile)

        get "#{profiles_url}/list", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :address, :dateOfBirth, :email, 
                                                           :firstName, :lastName, :nickname, :phone, 
                                                           :cityId, :userId).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        get profiles_url

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # save - create
  # ------------------
  describe "POST /" do
    # User logged & admin
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns organizations serialized' do
        city    = FactoryBot.create(:location_city)

        post profiles_url, params: {
          profile: { 
            first_name: Faker::Games::DnD.first_name,
            last_name: Faker::Games::DnD.last_name,
            address: Faker::Address.full_address,
            phone: Faker::PhoneNumber.phone_number_with_country_code,
            email: Faker::Internet.email,
            date_of_birth: Faker::Date.between(from: '1980-09-23', to: '2000-09-25'),
            nickname: Faker::Games::DnD.first_name,
            city_id: city.id
          } }, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :address, :dateOfBirth, :email, 
                                                           :firstName, :lastName, :nickname, :phone, 
                                                           :cityId, :userId).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        get profiles_url

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # save - update
  # ------------------
  describe "POST /" do
    # User logged & admin
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns organizations serialized' do
        profile = FactoryBot.create(:users_profile, user:)
        city    = FactoryBot.create(:location_city)

        post profiles_url, params: {
          profile: { 
            first_name: Faker::Games::DnD.first_name,
            last_name: Faker::Games::DnD.last_name,
            address: Faker::Address.full_address,
            phone: Faker::PhoneNumber.phone_number_with_country_code,
            email: Faker::Internet.email,
            date_of_birth: Faker::Date.between(from: '1980-09-23', to: '2000-09-25'),
            nickname: Faker::Games::DnD.first_name,
            city_id: city.id
          } }, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :address, :dateOfBirth, :email, 
                                                        :firstName, :lastName, :nickname, :phone, 
                                                        :cityId, :userId).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        get profiles_url

        expect(response.status).to eq(401)
      end
    end
  end
end