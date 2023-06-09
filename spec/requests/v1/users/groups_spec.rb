require 'rails_helper'

RSpec.describe "V1::Users::Groups", type: :request do
  let (:admin) { create_admin }
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:groups_url) { '/v1/users/groups' }

  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns groups serialized' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        get groups_url, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :description, :kind, :name, 
                                                           :adminId, :organizationId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        get groups_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # show
  # -------------------------------------------------------------------------------------
  describe "GET /:group_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns group serialized' do
        group = FactoryBot.create(:users_group)
        group.users << user
        group.save!

        get "#{groups_url}/#{group.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :description, :kind, :name, 
                                                        :adminId, :organizationId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        get groups_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns group serialized' do
        organization = FactoryBot.create(:organization)

        post "#{groups_url}", params: {
          group: { 
            name: Faker::FunnyName.name,
            description: Faker::Books::Lovecraft.paragraph,
            kind: Users::Group::kind_options.keys.sample,
            admin_id: admin.id,
            organization_id: organization.id
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :description, :kind, :name, 
                                                        :adminId, :organizationId).exactly
      end
    end

    # --------------------
    # User not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        get groups_url

        expect(response.status).to eq(401)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        get groups_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # update
  # -------------------------------------------------------------------------------------
  describe "PUT /:group_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns group serialized' do
        group = FactoryBot.create(:users_group)

        put "#{groups_url}/#{group.id}", params: {
          group: { 
            name: Faker::FunnyName.name,
            description: Faker::Books::Lovecraft.paragraph,
            kind: Users::Group::kind_options.keys.sample,
            admin_id: admin.id,
            organization_id: group.organization.id
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :description, :kind, :name, 
                                                        :adminId, :organizationId).exactly
      end
    end

    # --------------------
    # User not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        get groups_url

        expect(response.status).to eq(401)
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        get groups_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # destroy
  # -------------------------------------------------------------------------------------
  describe "DELETE /:group_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(admin)
      end

      it 'returns done: ok' do
        group = FactoryBot.create(:users_group)

        delete "#{groups_url}/#{group.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['done']).to eq('ok')
      end
    end

    # --------------------
    # User not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        get groups_url

        expect(response.status).to eq(401)
      end
    end

    # --------------------
    # User without group
    # --------------------
    context 'when no group' do
      before do
        login_with_api(admin)
      end

      it 'returns an error' do
        delete "#{groups_url}/12345-4", headers: {
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
        get groups_url

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # list
  # -------------------------------------------------------------------------------------
  describe "GET /list" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When admin' do
      before do
        login_with_api(admin)
      end

      it 'returns all groups serialized' do
        group = FactoryBot.create(:users_group)

        get "#{groups_url}/list", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :description, :kind, :name, 
                                                           :adminId, :organizationId).exactly
      end
    end

    # --------------------
    # User not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        get "#{groups_url}/list"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # Add member
  # -------------------------------------------------------------------------------------
  describe "POST /add-member" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When admin' do
      before do
        login_with_api(admin)
      end

      it 'returns all groups serialized' do
        group = FactoryBot.create(:users_group)
        user  = FactoryBot.create(:user)

        post "#{groups_url}/#{group.id}/add-member",  params: {
          group: { 
            member_id: user.id
          } }, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :description, :kind, :name, 
                                                           :adminId, :organizationId).exactly
      end
    end

    # --------------------
    # User not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        group = FactoryBot.create(:users_group)
        user  = FactoryBot.create(:user)

        post "#{groups_url}/#{group.id}/add-member",  params: {
          group: { 
            member_id: user.id
          } 
        }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # Remove member
  # -------------------------------------------------------------------------------------
  describe "POST /remove-member" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When admin' do
      before do
        login_with_api(admin)
      end

      it 'returns all groups serialized' do
        group = FactoryBot.create(:users_group)
        user  = FactoryBot.create(:user)
        group.users << user

        post "#{groups_url}/#{group.id}/remove-member",  params: {
          group: { 
            member_id: user.id
          } }, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :description, :kind, :name, 
                                                           :adminId, :organizationId).exactly
      end
    end

    # --------------------
    # User not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        group = FactoryBot.create(:users_group)
        user  = FactoryBot.create(:user)
        group.users << user

        post "#{groups_url}/#{group.id}/remove-member",  params: {
          group: { 
            member_id: user.id
          } 
        }

        expect(response.status).to eq(401)
      end
    end
  end
end