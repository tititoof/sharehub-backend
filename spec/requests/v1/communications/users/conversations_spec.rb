require 'rails_helper'

RSpec.describe "V1::Communications::Users::Conversations", type: :request do
  let (:user) { create_user }
  let (:admin) { create_admin }
  let (:login_url) { '/login' }
  let (:conversations_url) { '/v1/communications/users' }

  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /" do
    # --------------------
    # User logged
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns conversations serialized' do
        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant, member: user)

        get "#{conversations_url}/conversations", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :name).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        user = FactoryBot.create(:user)

        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant, member: user)

        get "#{conversations_url}/conversations"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /conversations" do
    # --------------------
    # User in group
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns conversation serialized' do
        post "#{conversations_url}/conversations", params: {
          conversation: { 
            name: Faker::Game.title,
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :name).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        post "#{conversations_url}/conversations", params: {
          conversation: { 
            name: Faker::Game.title,
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # update
  # -------------------------------------------------------------------------------------
  describe "PUT /conversations/:conversation_id" do
    # --------------------
    # User in group
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns conversation serialized' do
        participant = FactoryBot.create(:communications_participant, member: user)

        put "#{conversations_url}/conversations/#{participant.conversation.id}", params: {
          conversation: { 
            name: Faker::Game.title,
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :name).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        user = FactoryBot.create(:user)

        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant, member: user)

        put "#{conversations_url}/conversations/#{conversation.id}", params: {
          conversation: { 
            name: Faker::Game.title,
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # destroy
  # -------------------------------------------------------------------------------------
  describe "DELETE /conversations/:conversation_id" do
    # --------------------
    # User in group
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns done :ok' do
        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant, member: user)

        delete "#{conversations_url}/conversations/#{conversation.id}", headers: {
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
        user = FactoryBot.create(:user)
        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant, member: user)

        delete "#{conversations_url}/conversations/#{conversation.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end