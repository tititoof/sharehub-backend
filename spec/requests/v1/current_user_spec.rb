require 'rails_helper'

RSpec.describe "V1::CurrentUsers", type: :request do
  
  describe "GET /index" do
    let (:user) { create_user }
    let (:login_url) { '/login' }

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

      it 'returns the user email, createdAt & id' do
        get "/v1/current_user/index", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:createdAt, :id, :email, :isAdmin).exactly
      end
    end

    context 'When not logged in' do
      it 'returns 401' do
        get "/v1/current_user/index"

        expect(response.status).to eq(401)
      end
    end
  end
end
