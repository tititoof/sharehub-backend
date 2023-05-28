require 'rails_helper'

RSpec.describe "V1::Communications::Groups::Conversations", type: :request do
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:conversations_url) { '/v1/communications/groups' }

  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /:group_id" do
    # --------------------
    # User logged
    # --------------------
    context 'When logged in and in group' do
      before do
        login_with_api(user)
      end

      it 'returns conversations serialized' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant_group, member: group)

        get "#{conversations_url}/#{group.id}/conversations", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :name).exactly
      end
    end

    # --------------------
    # User not in group
    # --------------------
    context 'When not in group' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        group = FactoryBot.create(:users_group)
        
        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant_group, member: group)

        get "#{conversations_url}/#{group.id}/conversations", headers: {
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
        group = FactoryBot.create(:users_group)

        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant_group, member: group)

        get "#{conversations_url}/#{group.id}/conversations"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /:group_id/conversations" do
    # --------------------
    # User in group
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns conversation serialized' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.admin = user
        group.save!

        post "#{conversations_url}/#{group.id}/conversations", params: {
          conversation: { 
            name: Faker::Game.title,
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :name).exactly
      end
    end

    # --------------------
    # User not in group
    # --------------------
    context 'When not in group' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        group = FactoryBot.create(:users_group)

        post "#{conversations_url}/#{group.id}/conversations", params: {
          conversation: { 
            name: Faker::Game.title,
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
        group = FactoryBot.create(:users_group)

        post "#{conversations_url}/#{group.id}/conversations", params: {
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
  describe "PUT /:group_id/conversations/:conversation_id" do
    # --------------------
    # User in group
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns conversation serialized' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.admin = user
        group.save!

        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant_group, member: group)

        put "#{conversations_url}/#{group.id}/conversations/#{conversation.id}", params: {
          conversation: { 
            name: Faker::Game.title,
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :name).exactly
      end
    end

    # --------------------
    # User not in group
    # --------------------
    context 'When not in group' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        group = FactoryBot.create(:users_group)
        group.save!

        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant_group, member: group)

        put "#{conversations_url}/#{group.id}/conversations/#{conversation.id}", params: {
          conversation: { 
            name: Faker::Game.title,
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
        group = FactoryBot.create(:users_group)

        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant_group, member: group)

        put "#{conversations_url}/#{group.id}/conversations/#{conversation.id}", params: {
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
  describe "DELETE /:group_id/conversations/:conversation_id" do
    # --------------------
    # User in group
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns done :ok' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.admin = user
        group.save!

        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant_group, member: group)

        delete "#{conversations_url}/#{group.id}/conversations/#{conversation.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['done']).to eq('ok')
      end
    end

    # --------------------
    # User not in group
    # --------------------
    context 'When not in group' do
      before do
        login_with_api(user)
      end

      it 'returns an error' do
        group = FactoryBot.create(:users_group)
        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant_group, member: group)

        delete "#{conversations_url}/#{group.id}/conversations/#{conversation.id}", headers: {
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
        group = FactoryBot.create(:users_group)
        conversation = FactoryBot.create(:communications_conversation)
        participant = FactoryBot.create(:communications_participant_group, member: group)

        delete "#{conversations_url}/#{group.id}/conversations/#{conversation.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end