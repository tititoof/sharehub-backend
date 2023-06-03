require 'rails_helper'

RSpec.describe "V1::SourceControls::Giteas", type: :request do
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:test_url) { '/v1/source_controls/giteas' }

  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /v1/source_controls/giteas" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns giteas serialized' do
        gitea = FactoryBot.create(:source_controls_gitea)

        get "#{test_url}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :accessToken, 
                                                           :apiUrl, :ipAddress, :port).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        gitea = FactoryBot.create(:source_controls_gitea)

        get "#{test_url}"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # show
  # -------------------------------------------------------------------------------------
  describe "GET /v1/source_controls/giteas/:gitea_id" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns giteas serialized' do
        gitea = FactoryBot.create(:source_controls_gitea)

        get "#{test_url}/#{gitea.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :accessToken, 
                                                        :apiUrl, :ipAddress, :port).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        gitea = FactoryBot.create(:source_controls_gitea)

        get "#{test_url}/#{gitea.id}"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /v1/source_controls/giteas" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns gitea serialized' do
        post "#{test_url}", params: {
          gitea: { 
            api_url: Faker::Internet.url,
            access_token: Faker::Internet.uuid,
            ip_address: Faker::Internet.ip_v4_address,
            port: Faker::Number.number(digits: 4)
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :accessToken, 
                                                        :apiUrl, :ipAddress, :port).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        post "#{test_url}", params: {
          gitea: { 
            api_url: Faker::Internet.url,
            access_token: Faker::Internet.uuid,
            ip_address: Faker::Internet.ip_v4_address,
            port: Faker::Number.number(digits: 4)
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # update
  # -------------------------------------------------------------------------------------
  describe "PUT /v1/source_controls/giteas/:gitea_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns project serialized' do
        gitea = FactoryBot.create(:source_controls_gitea)

        put "#{test_url}/#{gitea.id}", params: {
          gitea: { 
            api_url: Faker::Internet.url,
            access_token: Faker::Internet.uuid,
            ip_address: Faker::Internet.ip_v4_address,
            port: Faker::Number.number(digits: 4)
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :accessToken, 
                                                        :apiUrl, :ipAddress, :port).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        gitea = FactoryBot.create(:source_controls_gitea)

        put "#{test_url}/#{gitea.id}", params: {
          gitea: { 
            api_url: Faker::Internet.url,
            access_token: Faker::Internet.uuid,
            ip_address: Faker::Internet.ip_v4_address,
            port: Faker::Number.number(digits: 4)
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # destroy
  # -------------------------------------------------------------------------------------
  describe "DELETE /v1/source_controls/giteas/:gitea_id" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns done : ok' do
        gitea = FactoryBot.create(:source_controls_gitea)

        delete "#{test_url}/#{gitea.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['done']).to eq('ok')
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        gitea = FactoryBot.create(:source_controls_gitea)
        
        delete "#{test_url}/#{gitea.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end