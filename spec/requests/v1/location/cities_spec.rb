require 'rails_helper'

RSpec.describe "V1::Cities", type: :request do
  describe "GET /cities" do
    let (:user) { create_user }
    let (:login_url) { '/login' }
    let (:cities_url) { '/v1/location/cities' }

    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns a token' do
        expect(response.headers['Authorization']).to be_present
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'returns the city serializer' do
        city = FactoryBot.create(:location_city)

        get "#{cities_url}/#{city.state_id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :name, :latitude, :longitude).exactly
      end
    end

    context 'When logged in' do
      it 'returns 401' do
        city = FactoryBot.create(:location_city)

        get "#{cities_url}/#{city.state_id}"

        expect(response.status).to eq(401)
      end
    end
  end
end
