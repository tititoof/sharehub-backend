require 'rails_helper'

RSpec.describe "V1::Communications::Users::Messages", type: :request do
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:messages_url) { '/v1/communications/users' }

  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /conversations/:conversation_id/messages" do
    # --------------------
    # User logged
    # --------------------
    context 'When logged in and in group' do
      before do
        login_with_api(user)
      end

      it 'returns conversations serialized' do
        participant = FactoryBot.create(:communications_participant, member: user)
        message = FactoryBot.create(:communications_message, conversation: participant.conversation)

        get "#{messages_url}/conversations/#{participant.conversation.id}/messages", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :content).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        participant = FactoryBot.create(:communications_participant, member: user)

        get "#{messages_url}/conversations/#{participant.conversation.id}/messages"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /:group_id/conversations/:conversation_id/messages" do
    # --------------------
    # User logged
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns conversation serialized' do
        participant = FactoryBot.create(:communications_participant, member: user)
        message = FactoryBot.create(:communications_message, conversation: participant.conversation)

        post "#{messages_url}/conversations/#{participant.conversation.id}/messages", params: {
          message: { 
            content: Faker::Game.title,
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :content).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        participant = FactoryBot.create(:communications_participant, member: user)
        message = FactoryBot.create(:communications_message, conversation: participant.conversation)

        post "#{messages_url}/conversations/#{participant.conversation.id}/messages", params: {
          message: { 
            content: Faker::Game.title,
          } }

        expect(response.status).to eq(401)
      end
    end
  end
end
