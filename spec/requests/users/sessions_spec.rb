require 'rails_helper'

describe "Users::Sessions", type: :request do
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:logout_url) { '/logout' }

  # -------------------------------------------------------------------------------------
  # login
  # -------------------------------------------------------------------------------------
  
  # --------------------
  # User with passowrd and email
  # --------------------
  context 'When logging in' do
    before do
      login_with_api(user)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
  end

  # --------------------
  # User with email and without passowrd
  # --------------------
  context 'When password is missing' do
    before do
      post login_url, params: {
        user: {
          email: user.email,
          password: nil
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end

  # -------------------------------------------------------------------------------------
  # logout
  # -------------------------------------------------------------------------------------
  context 'When logging out' do
    it 'returns 401' do
      delete logout_url

      expect(response).to have_http_status(401)
    end
  end
end