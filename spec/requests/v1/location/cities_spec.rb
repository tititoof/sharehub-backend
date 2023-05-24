require 'rails_helper'

RSpec.describe "V1::Cities", type: :request do
  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /cities" do
    let (:user) { create_user }
    let (:login_url) { '/login' }
    let (:cities_url) { '/v1/location/cities' }

    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns the city serializer' do
        city = FactoryBot.create(:location_city)

        get "#{cities_url}/#{city.state_id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :name, :latitude, :longitude).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        city = FactoryBot.create(:location_city)

        get "#{cities_url}/#{city.state_id}"

        expect(response.status).to eq(401)
      end
    end
  end
end
