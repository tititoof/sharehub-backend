require 'rails_helper'

describe "Users::Registration", type: :request do
  let (:user) { build_user }
  let (:existing_user) { create_user }
  let (:signup_url) { '/signup' }

  # -------------------------------------------------------------------------------------
  # signup
  # -------------------------------------------------------------------------------------
  
  # --------------------
  # User not present in db
  # --------------------
  context 'When creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end
  end
  
  # --------------------
  # User present in db
  # --------------------
  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns 422' do
      expect(response.status).to eq(422)
    end
  end

end