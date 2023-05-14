require 'rails_helper'

RSpec.describe "V1::Countries", type: :request do
  describe "GET /countries" do
    let (:user) { create_user }
    let (:login_url) { '/login' }
    let (:countries_url) { '/v1/location/countries' }

    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns the country serializer' do
        country = FactoryBot.create(:location_country)

        get countries_url, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :name, :emoji).exactly
      end
    end

    context 'When not logged in' do
      it 'returns 401' do
        get countries_url

        expect(response.status).to eq(401)
      end
    end
  end
end
