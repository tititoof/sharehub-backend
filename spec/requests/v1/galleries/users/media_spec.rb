require 'rails_helper'

RSpec.describe "V1::Galleries::Users::Media", type: :request do
  let (:admin) { create_admin }
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:albums_url) { '/v1/galleries/users' }

  def image_file(size: '300x300', format: 'png', background_color: nil, text_color: nil, text: nil)
    file = Tempfile.new("faker_placeholdit")
    file.binmode
    file << Net::HTTP.get(URI(Faker::Placeholdit.image(size: size, format: format, background_color: background_color, text_color: text_color, text: text)))
    file.close
  
    ::File.new(file.path)
  end

  # ------------------
  # index
  # ------------------
  describe "GET /albums/:album_id/media" do
    # User logged & admin
    context 'When logged in and in group' do
      before do
        login_with_api(user)
      end

      it 'returns medium serialized' do
        album = FactoryBot.create(:galleries_album, albumable: user)
        media = FactoryBot.create(:galleries_medium, album:)
        media.file.attach(io: image_file, filename: 'test')
        media.save!

        get "#{albums_url}/albums/#{album.id}/media", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :kind, :albumId).exactly
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        album = FactoryBot.create(:galleries_album, albumable: user)
        media = FactoryBot.create(:galleries_medium, album:)
        media.file.attach(io: image_file, filename: 'test')
        media.save!

        get "#{albums_url}/albums/#{album.id}/media"

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # show
  # ------------------
  describe "GET /albums/:album_id/media/:medium_id" do
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns album serialized' do
        album = FactoryBot.create(:galleries_album, albumable: user)
        media = FactoryBot.create(:galleries_medium, album:)
        media.file.attach(io: image_file, filename: 'test')
        media.save!

        get "#{albums_url}/albums/#{album.id}/media/#{media.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(response.status).to eq(302)
      end
    end

    # User not logged
    context 'When not logged in' do
      it 'returns 401' do
        album = FactoryBot.create(:galleries_album, albumable: user)
        media = FactoryBot.create(:galleries_medium, album:)
        media.file.attach(io: image_file, filename: 'test')
        media.save!

        get "#{albums_url}/albums/#{album.id}/media/#{media.id}"

        expect(response.status).to eq(401)
      end
    end
  end

  # ------------------
  # create
  # ------------------
  describe "POST /albums/:album_id/media" do
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns albums serialized' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        file  = fixture_file_upload(Rails.root.join('spec', 'storage', 'avatar.jpg'), 'image/jpeg')

        post "#{albums_url}/albums/#{album.id}/media", params: {
          medium: { 
            medium: file,
            kind: 'image'
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :kind, :albumId).exactly
      end
    end

    context 'When not logged in' do
      it 'returns 401' do
        album = FactoryBot.create(:galleries_album, albumable: user)

        post "#{albums_url}/albums/#{album.id}/media", params: {
          medium: { 
            medium: image_file,
            kind: 'image'
          } }

        expect(response.status).to eq(401)
      end
    end
  end
end