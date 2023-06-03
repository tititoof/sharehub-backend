require 'rails_helper'

RSpec.describe "V1::Organizations", type: :request do
  let (:admin) { create_admin }
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:organizations_url) { '/v1/organizations' }
  
  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /organizations/:organization_id/projects" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns projects serialized' do
        project = FactoryBot.create(:project)

        get "#{organizations_url}/#{project.organization.id}/projects", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :category, :description, :endAt, 
                                                           :externalReferences, :startAt, :status,
                                                           :title, :managerId, :organizationId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        project = FactoryBot.create(:project)

        get "#{organizations_url}/#{project.organization.id}/projects"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # show
  # -------------------------------------------------------------------------------------
  describe "GET organizations/:organization_id/projects/:project_id" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns organizations serialized' do
        project = FactoryBot.create(:project)

        get "#{organizations_url}/#{project.organization.id}/projects/#{project.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :category, :description, :endAt, 
                                                        :externalReferences, :startAt, :status,
                                                        :title, :managerId, :organizationId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        project = FactoryBot.create(:project)

        get "#{organizations_url}/#{project.organization.id}/projects/#{project.id}"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /organizations/:organization_id/projects" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns project serialized' do
        organization = FactoryBot.create(:organization, admin: user)

        post "#{organizations_url}/#{organization.id}/projects/", params: {
          project: { 
            title: Faker::Commerce.product_name,
            description: Faker::Books::Lovecraft.paragraph,
            start_at: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
            end_at: Faker::Date.between(from: '2014-10-23', to: '2014-10-25'),
            status: Project::project_status_options.keys.sample,
            manager: user.id,
            external_references: "MyString",
            category: Project::project_category_options.keys.sample
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :category, :description, :endAt, 
                                                        :externalReferences, :startAt, :status,
                                                        :title, :managerId, :organizationId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        organization = FactoryBot.create(:organization)
        user = FactoryBot.create(:user)

        post "#{organizations_url}/#{organization.id}/projects/", params: {
          project: { 
            title: Faker::Commerce.product_name,
            description: Faker::Books::Lovecraft.paragraph,
            start_at: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
            end_at: Faker::Date.between(from: '2014-10-23', to: '2014-10-25'),
            status: Project::project_status_options.keys.sample,
            manager: user.id,
            external_references: "MyString",
            category: Project::project_category_options.keys.sample
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # update
  # -------------------------------------------------------------------------------------
  describe "PUT /:organization_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns project serialized' do
        project = FactoryBot.create(:project)

        put "#{organizations_url}/#{project.organization.id}/projects/#{project.id}", params: {
          project: { 
            title: Faker::Commerce.product_name,
            description: Faker::Books::Lovecraft.paragraph,
            start_at: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
            end_at: Faker::Date.between(from: '2014-10-23', to: '2014-10-25'),
            status: Project::project_status_options.keys.sample,
            manager: user.id,
            external_references: "MyString",
            category: Project::project_category_options.keys.sample
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :category, :description, :endAt, 
                                                        :externalReferences, :startAt, :status,
                                                        :title, :managerId, :organizationId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        project = FactoryBot.create(:project)
        user = FactoryBot.create(:user)

        put "#{organizations_url}/#{project.organization.id}/projects/#{project.id}", params: {
          project: { 
            title: Faker::Commerce.product_name,
            description: Faker::Books::Lovecraft.paragraph,
            start_at: Faker::Date.between(from: '2014-09-23', to: '2014-09-25'),
            end_at: Faker::Date.between(from: '2014-10-23', to: '2014-10-25'),
            status: Project::project_status_options.keys.sample,
            manager: user.id,
            external_references: "MyString",
            category: Project::project_category_options.keys.sample
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # destroy
  # -------------------------------------------------------------------------------------
  describe "DELETE /:organization_id" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns done : ok' do
        project = FactoryBot.create(:project)

        delete "#{organizations_url}/#{project.organization.id}/projects/#{project.id}", headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['done']).to eq('ok')
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    # context 'When not admin' do
    #   before do
    #     login_with_api(user)
    #   end

    #   it 'not authorize' do
    #     get organizations_url

    #     expect(response.status).to eq(401)
    #   end
    # end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        project = FactoryBot.create(:project)
        
        delete "#{organizations_url}/#{project.organization.id}/projects/#{project.id}"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # Add member
  # -------------------------------------------------------------------------------------
  describe "POST /add-member" do
    # --------------------
    # User logged in 
    # --------------------
    context 'When admin' do
      before do
        login_with_api(user)
      end

      it 'returns project serialized' do
        project = FactoryBot.create(:project)
        user  = FactoryBot.create(:user)

        post "#{organizations_url}/#{project.organization.id}/projects/#{project.id}/add-member",  params: {
          project: { 
            member_id: user.id
          } }, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :category, :description, :endAt, 
                                                        :externalReferences, :startAt, :status,
                                                        :title, :managerId, :organizationId).exactly
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        project = FactoryBot.create(:project)
        user  = FactoryBot.create(:user)

        post "#{organizations_url}/#{project.organization.id}/projects/#{project.id}/add-member",  params: {
          project: { 
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
        login_with_api(user)
      end

      it 'returns all groups serialized' do
        project = FactoryBot.create(:project)
        user  = FactoryBot.create(:user)
        project.members << user

        post "#{organizations_url}/#{project.organization.id}/projects/#{project.id}/remove-member",  params: {
          project: { 
            member_id: user.id
          } }, headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :category, :description, :endAt, 
                                                        :externalReferences, :startAt, :status,
                                                        :title, :managerId, :organizationId).exactly
      end
    end

    # --------------------
    # User logged in & not admin
    # --------------------
    context 'When not admin' do
      before do
        login_with_api(user)
      end

      it 'not authorize' do
        project = FactoryBot.create(:project)
        user  = FactoryBot.create(:user)
        project.members << user

        post "#{organizations_url}/#{project.organization.id}/projects/#{project.id}/remove-member",  params: {
          project: { 
            member_id: user.id
          } 
        }

        expect(response.status).to eq(401)
      end
    end
  end
end