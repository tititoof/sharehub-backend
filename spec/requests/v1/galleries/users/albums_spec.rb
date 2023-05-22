require 'rails_helper'

RSpec.describe "V1::Galleries::Users::Albums", type: :request do
  let (:admin) { create_admin }
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:albums_url) { '/v1/galleries/users' }

  # ------------------
  # index
  # ------------------
  describe "GET /" do
    # User logged & admin
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns albums serialized' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        get "#{albums_url}/albums", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :aasmState, :title, :description).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        get "#{albums_url}/albums"

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # show
  # ------------------
  describe "GET /albums/:album_id" do
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns album serialized' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        get "#{albums_url}/albums/#{album.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :aasmState, :title, :description).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        get "#{albums_url}/albums/#{album.id}"

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # create
  # ------------------
  describe "POST /albums" do
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns albums serialized' do
        post "#{albums_url}/albums", params: {
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

    context 'When not logged in' do
      it 'returns 401' do
        post "#{albums_url}/albums", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # update
  # ------------------
  describe "PUT /albums/:album_id" do
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns albums serialized' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        put "#{albums_url}/albums/#{album.id}", params: {
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

    context 'When not logged in' do
      it 'returns 401' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        put "#{albums_url}/albums/#{album.id}", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # destroy
  # ------------------
  describe "DELETE /albums/:album_id" do
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns done :ok' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        delete "#{albums_url}/albums/#{album.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['done']).to eq('ok')
      end
    end

    context 'When not logged in' do
      it 'returns 401' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        delete "#{albums_url}/albums/#{album.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end