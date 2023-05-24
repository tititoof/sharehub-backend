require 'rails_helper'

RSpec.describe "V1::State", type: :request do
  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /states" do
    let (:user) { create_user }
    let (:login_url) { '/login' }
    let (:states_url) { '/v1/location/states' }

    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns the state serializer' do
        state = FactoryBot.create(:location_state)

        get "#{states_url}/#{state.country_id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :name, :countryId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        state = FactoryBot.create(:location_state)

        get "#{states_url}/#{state.country_id}"

        expect(response.status).to eq(401)
      end
    end
  end
end
