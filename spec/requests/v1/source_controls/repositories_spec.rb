require 'rails_helper'

RSpec.describe "V1::SourceControls::Repositories", type: :request do
  let (:user) { create_user }
  let (:login_url) { '/login' }
  let (:test_url) { '/v1/source_controls/projects' }

  # -------------------------------------------------------------------------------------
  # index
  # -------------------------------------------------------------------------------------
  describe "GET /v1/source_controls/projects/:project_id/repositories" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns giteas serialized' do
        project = FactoryBot.create(:project)
        project.members << user
        repository = FactoryBot.create(:source_controls_repository, project:)

        get "#{test_url}/#{project.id}/repositories", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data'][0]).to have_jsonapi_attributes(:id, :name, :owner, :repo, 
                                                           :sourcableType, :projectId, :sourcableId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        project = FactoryBot.create(:project)
        user    = FactoryBot.create(:user)
        project.members << user
        repository = FactoryBot.create(:source_controls_repository)

        get "#{test_url}/#{project.id}/repositories"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # show
  # -------------------------------------------------------------------------------------
  describe "GET /v1/source_controls/projects/:project_id/repositories/:repository_id" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns giteas serialized' do
        project = FactoryBot.create(:project)
        project.members << user
        repository = FactoryBot.create(:source_controls_repository)

        get "#{test_url}/#{project.id}/repositories/#{repository.id}", headers: {
          'Authorization': response.headers['Authorization']
        }

        expect(json['data']).to have_jsonapi_attributes(:id, :name, :owner, :repo, 
                                                        :sourcableType, :projectId, :sourcableId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        project = FactoryBot.create(:project)
        user    = FactoryBot.create(:user)
        project.members << user
        repository = FactoryBot.create(:source_controls_repository)

        get "#{test_url}/#{project.id}/repositories/#{repository.id}"

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # create
  # -------------------------------------------------------------------------------------
  describe "POST /v1/source_controls/projects/:project_id/repositories" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns gitea serialized' do
        project = FactoryBot.create(:project)
        project.manager = user
        project.save!
        gitea   = FactoryBot.create(:source_controls_gitea)

        post "#{test_url}/#{project.id}/repositories", params: {
          repository: {
            name: Faker::Company.name,
            owner: Faker::Name.initials,
            repo: Faker::Name.initials,
            project: project.id,
            sourcable_type: 'Gitea',
            sourcable_id: gitea.id
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :name, :owner, :repo, 
                                                        :sourcableType, :projectId, :sourcableId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        project = FactoryBot.create(:project)
        user    = FactoryBot.create(:user)
        project.members << user
        gitea   = FactoryBot.create(:source_controls_gitea)

        post "#{test_url}/#{project.id}/repositories", params: {
          repository: {
            name: Faker::Company.name,
            owner: Faker::Name.initials,
            repo: Faker::Name.initials,
            project: project.id,
            sourcable_type: 'Gitea',
            sourcable_id: gitea.id
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # update
  # -------------------------------------------------------------------------------------
  describe "PUT /v1/source_controls/projects/:project_id/repositories/:repository_id" do
    # --------------------
    # User logged in & admin
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns project serialized' do
        project = FactoryBot.create(:project)
        project.manager = user
        project.save!
        repository = FactoryBot.create(:source_controls_repository, project:)
        gitea   = FactoryBot.create(:source_controls_gitea)

        put "#{test_url}/#{project.id}/repositories/#{repository.id}", params: {
          repository: {
            name: Faker::Company.name,
            owner: Faker::Name.initials,
            repo: Faker::Name.initials,
            project: project.id,
            sourcable_type: 'Gitea',
            sourcable_id: gitea.id
          } }, headers: {
            'Authorization': response.headers['Authorization']
          }

        expect(json['data']).to have_jsonapi_attributes(:id, :name, :owner, :repo, 
                                                        :sourcableType, :projectId, :sourcableId).exactly
      end
    end

    # --------------------
    # User not logged
    # --------------------
    context 'When not logged in' do
      it 'returns 401' do
        project = FactoryBot.create(:project)
        user    = FactoryBot.create(:user)
        project.members << user
        repository = FactoryBot.create(:source_controls_repository, project:)
        gitea   = FactoryBot.create(:source_controls_gitea)

        put "#{test_url}/#{project.id}/repositories/#{repository.id}", params: {
          repository: {
            name: Faker::Company.name,
            owner: Faker::Name.initials,
            repo: Faker::Name.initials,
            project: project.id,
            sourcable_type: 'Gitea',
            sourcable_id: gitea.id
          } }

        expect(response.status).to eq(401)
      end
    end
  end

  # -------------------------------------------------------------------------------------
  # destroy
  # -------------------------------------------------------------------------------------
  describe "DELETE /v1/source_controls/projects/:project_id/repositories/:repository_id" do
    # --------------------
    # User logged in
    # --------------------
    context 'When logged in' do
      before do
        login_with_api(user)
      end

      it 'returns done : ok' do
        project = FactoryBot.create(:project)
        project.manager = user
        project.save!
        repository = FactoryBot.create(:source_controls_repository, project:)

        delete "#{test_url}/#{project.id}/repositories/#{repository.id}", headers: {
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
        project = FactoryBot.create(:project)
        user    = FactoryBot.create(:user)
        project.members << user
        repository = FactoryBot.create(:source_controls_repository, project:)
        
        delete "#{test_url}/#{project.id}/repositories/#{repository.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end