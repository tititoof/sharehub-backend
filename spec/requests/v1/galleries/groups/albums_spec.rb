require 'rails_helper'

RSpec.describe "V1::Galleries::Groups::Albums", type: :request do
  let (:admin) { create_admin }
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:albums_url) { '/v1/galleries/groups' }

  # ------------------
  # index
  # ------------------
  describe "GET /:group_id" do
    # User logged & admin
    context 'When logged in and in group' do
      before do
        login_with_api(user)
      end

      it 'returns albums serialized' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        album = FactoryBot.create(:galleries_album_group, albumable: group)

        get "#{albums_url}/#{group.id}/albums", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :aasmState, :title, :description).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        album = FactoryBot.create(:galleries_album_group, albumable: group)

        get "#{albums_url}/#{group.id}/albums"

        expect(response.status).to eq(401)
      end
    end

    # User not in group
    context 'When not in group' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        group = FactoryBot.create(:users_group)
        album = FactoryBot.create(:galleries_album_group, albumable: group)

        get "#{albums_url}/#{group.id}/albums", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(response.status).to eq(422)
      end
    end
  end

  # ------------------
  # show
  # ------------------
  describe "GET /:group_id/albums/:album_id" do
    context 'When logged in and in group' do
      before do
        login_with_api(user)
      end

      it 'returns album serialized' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        album = FactoryBot.create(:galleries_album_group, albumable: group)

        get "#{albums_url}/#{group.id}/albums/#{album.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :aasmState, :title, :description).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        album = FactoryBot.create(:galleries_album_group, albumable: group)

        get "#{albums_url}/#{group.id}/albums/#{album.id}"

        expect(response.status).to eq(401)
      end
    end

    # User not in group
    context 'When not in group' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        group = FactoryBot.create(:users_group)
        album = FactoryBot.create(:galleries_album_group, albumable: group)

        get "#{albums_url}/#{group.id}/albums/#{album.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(response.status).to eq(422)
      end
    end
  end

  # ------------------
  # create
  # ------------------
  describe "POST /:group_id/albums" do
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns albums serialized' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        post "#{albums_url}/#{group.id}/albums", params: {
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
        group = FactoryBot.create(:users_group)

        post "#{albums_url}/#{group.id}/albums", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }

        expect(response.status).to eq(401)
      end
    end

    context 'When not in group' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        group = FactoryBot.create(:users_group)

        post "#{albums_url}/#{group.id}/albums", params: {
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
  end

  # ------------------
  # update
  # ------------------
  describe "PUT /:group_id/albums/:album_id" do
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns albums serialized' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        album = FactoryBot.create(:galleries_album_group, albumable: group)

        put "#{albums_url}/#{group.id}/albums/#{album.id}", params: {
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
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        album = FactoryBot.create(:galleries_album_group, albumable: group)

        put "#{albums_url}/#{group.id}/albums/#{album.id}", params: {
          album: { 
            title: Faker::Game.title,
            description: Faker::Books::Lovecraft.paragraph,
            aasm_state: :draft
          } }

        expect(response.status).to eq(401)
      end
    end

    context 'When not in group' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        group = FactoryBot.create(:users_group)
        album = FactoryBot.create(:galleries_album_group, albumable: group)

        put "#{albums_url}/#{group.id}/albums/#{album.id}", params: {
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
  end

  # ------------------
  # destroy
  # ------------------
  describe "DELETE /:group_id/albums/:album_id" do
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns done :ok' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.admin = user
        group.save!

        album = FactoryBot.create(:galleries_album_group, albumable: group)

        delete "#{albums_url}/#{group.id}/albums/#{album.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['done']).to eq('ok')
      end
    end

    context 'When not in group' do
      before do
        login_with_api(user)
      end

      it 'returns an error' do
        group = FactoryBot.create(:users_group)
        album = FactoryBot.create(:galleries_album_group, albumable: group)

        delete "#{albums_url}/#{group.id}/albums/#{album.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(response.status).to eq(422)
      end
    end

    context 'When not logged in' do
      it 'returns 401' do
        group = FactoryBot.create(:users_group)
        album = FactoryBot.create(:galleries_album_group, albumable: group)

        delete "#{albums_url}/#{group.id}/albums/#{album.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end