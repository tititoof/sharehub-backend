require 'rails_helper'

RSpec.describe "V1::SourceControls::Giteas", type: :request do
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:test_url) { '/v1/source_controls/organizations' }

  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /v1/source_controls/organizations/:organization_id/giteas" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns giteas serialized' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        gitea        = FactoryBot.create(:source_controls_gitea, organization:)

        get "#{test_url}/#{organization.id}/giteas", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :accessToken, :name,
                                                           :apiUrl, :ipAddress, :port).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)
        gitea        = FactoryBot.create(:source_controls_gitea, organization:)

        get "#{test_url}/#{organization.id}/giteas"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # show
  # -------------------------------------------------------------------------------------
  describe "GET /v1/source_controls/organizations/:organization_id/giteas/:gitea_id" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns giteas serialized' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        gitea        = FactoryBot.create(:source_controls_gitea, organization:)

        get "#{test_url}/#{organization.id}/giteas/#{gitea.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :accessToken, :name,
                                                        :apiUrl, :ipAddress, :port).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)
        gitea        = FactoryBot.create(:source_controls_gitea, organization:)

        get "#{test_url}/#{organization.id}/giteas/#{gitea.id}"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /v1/source_controls/organizations/:organization_id/giteas" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns gitea serialized' do
        organization = FactoryBot.create(:organization)
        organization.admin = user
        organization.save!

        post "#{test_url}/#{organization.id}/giteas", params: {
          gitea: { 
            api_url: Faker::Internet.url,
            access_token: Faker::Internet.uuid,
            ip_address: Faker::Internet.ip_v4_address,
            port: Faker::Number.number(digits: 4),
            name: Faker::FunnyName.name
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :accessToken, :name,
                                                        :apiUrl, :ipAddress, :port).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)

        post "#{test_url}/#{organization.id}/giteas", params: {
          gitea: { 
            api_url: Faker::Internet.url,
            access_token: Faker::Internet.uuid,
            ip_address: Faker::Internet.ip_v4_address,
            port: Faker::Number.number(digits: 4),
            name: Faker::FunnyName.name
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # update
  # -------------------------------------------------------------------------------------
  describe "PUT /v1/source_controls/organizations/:organization_id/giteas/:gitea_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns project serialized' do
        organization = FactoryBot.create(:organization)
        organization.admin = user
        organization.save!
        gitea        = FactoryBot.create(:source_controls_gitea, organization:)

        put "#{test_url}/#{organization.id}/giteas/#{gitea.id}", params: {
          gitea: { 
            api_url: Faker::Internet.url,
            access_token: Faker::Internet.uuid,
            ip_address: Faker::Internet.ip_v4_address,
            port: Faker::Number.number(digits: 4),
            name: Faker::FunnyName.name
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :accessToken, :name,
                                                        :apiUrl, :ipAddress, :port).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)
        gitea        = FactoryBot.create(:source_controls_gitea, organization:)

        put "#{test_url}/#{organization.id}/giteas/#{gitea.id}", params: {
          gitea: { 
            api_url: Faker::Internet.url,
            access_token: Faker::Internet.uuid,
            ip_address: Faker::Internet.ip_v4_address,
            port: Faker::Number.number(digits: 4),
            name: Faker::FunnyName.name
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # destroy
  # -------------------------------------------------------------------------------------
  describe "DELETE /v1/source_controls/organizations/:organization_id/giteas/:gitea_id" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns done : ok' do
        organization = FactoryBot.create(:organization)
        organization.admin = user
        organization.save!
        gitea        = FactoryBot.create(:source_controls_gitea, organization:)

        delete "#{test_url}/#{organization.id}/giteas/#{gitea.id}", headers: {
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
        organization = FactoryBot.create(:organization)
        gitea        = FactoryBot.create(:source_controls_gitea, organization:)
        
        delete "#{test_url}/#{organization.id}/giteas/#{gitea.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end