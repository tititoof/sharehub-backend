require 'rails_helper'

RSpec.describe "V1::Galleries::Organizations::Albums", type: :request do
  let (:admin) { create_admin }
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:albums_url) { '/v1/galleries/organizations' }

  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /:organization_id" do
    # --------------------
    # User in organization
    # --------------------
    context 'When logged in and in organization' do
      before do
        login_with_api(user)
      end

      it 'returns albums serialized' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        organization.save!

        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        get "#{albums_url}/#{organization.id}/albums", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :aasmState, :title, :description).exactly
      end
    end

    # --------------------
    # User not in organization
    # --------------------
    context 'When not in organization' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        organization = FactoryBot.create(:organization)

        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        get "#{albums_url}/#{organization.id}/albums", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(response.status).to eq(422)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        organization.save!

        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        get "#{albums_url}/#{organization.id}/albums"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # show
  # -------------------------------------------------------------------------------------
  describe "GET /:organization_id/albums/:album_id" do
    # --------------------
    # User in organization
    # --------------------
    context 'When logged in and in organization' do
      before do
        login_with_api(user)
      end

      it 'returns album serialized' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        organization.save!

        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        get "#{albums_url}/#{organization.id}/albums/#{album.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :aasmState, :title, :description).exactly
      end
    end

    # --------------------
    # User not in organization
    # --------------------
    context 'When not in organization' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        organization = FactoryBot.create(:organization)
        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        get "#{albums_url}/#{organization.id}/albums/#{album.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(response.status).to eq(422)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        organization.save!

        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        get "#{albums_url}/#{organization.id}/albums/#{album.id}"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /:organization_id/albums" do
    # --------------------
    # User in organization
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns albums serialized' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        organization.save!

        post "#{albums_url}/#{organization.id}/albums", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :aasmState, :title, :description).exactly
      end
    end


    # --------------------
    # User not in organization
    # --------------------
    context 'When not in organization' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        organization = FactoryBot.create(:organization)

        post "#{albums_url}/#{organization.id}/albums", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(response.status).to eq(422)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)

        post "#{albums_url}/#{organization.id}/albums", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # update
  # -------------------------------------------------------------------------------------
  describe "PUT /:organization_id/albums/:album_id" do
    # --------------------
    # User in organization
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns albums serialized' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        organization.save!

        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        put "#{albums_url}/#{organization.id}/albums/#{album.id}", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :aasmState, :title, :description).exactly
      end
    end

    # --------------------
    # User not in organization
    # --------------------
    context 'When not in organization' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        organization = FactoryBot.create(:organization)
        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        put "#{albums_url}/#{organization.id}/albums/#{album.id}", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(response.status).to eq(422)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        organization.save!

        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        put "#{albums_url}/#{organization.id}/albums/#{album.id}", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # destroy
  # -------------------------------------------------------------------------------------
  describe "DELETE /:organization_id/albums/:album_id" do
    # --------------------
    # User in organization
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns done :ok' do
        organization = FactoryBot.create(:organization)
        organization.users << user
        organization.admin = user
        organization.save!

        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        delete "#{albums_url}/#{organization.id}/albums/#{album.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['done']).to eq('ok')
      end
    end

    # --------------------
    # User not in organization
    # --------------------
    context 'When not in organization' do
      before do
        login_with_api(user)
      end

      it 'returns an error' do
        organization = FactoryBot.create(:organization)
        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        delete "#{albums_url}/#{organization.id}/albums/#{album.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(response.status).to eq(422)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)
        album = FactoryBot.create(:galleries_album_organization, albumable: organization)

        delete "#{albums_url}/#{organization.id}/albums/#{album.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end