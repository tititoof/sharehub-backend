class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

Rails.application.routes.draw do
  
  devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    get 'current_user/index'

    # /location/
    namespace :location do
      # Countries
      get 'countries',          to: 'country#index'
      # States
      get 'states/:country_id', to: 'state#index'
      # Cities
      get 'cities/:state_id',   to: 'city#index'
    end

    # /organizations
    get     'organizations',                                to: 'organizations#index'
    get     'organizations/:organization_id',               to: 'organizations#show'
    post    'organizations',                                to: 'organizations#create'
    post    'organizations/:organization_id/add-member',    to: 'organizations#add_member'
    post    'organizations/:organization_id/remove-member', to: 'organizations#remove_member'
    put     'organizations/:organization_id',               to: 'organizations#update'
    delete  'organizations/:organization_id',               to: 'organizations#destroy'

    # /projects
    get     'organizations/:organization_id/projects',                            to: 'projects#index'
    get     'organizations/:organization_id/projects/:project_id',                to: 'projects#show'
    post    'organizations/:organization_id/projects',                            to: 'projects#create'
    post    'organizations/:organization_id/projects/:project_id/add-member',     to: 'projects#add_member'
    post    'organizations/:organization_id/projects/:project_id/remove-member',  to: 'projects#remove_member'
    put     'organizations/:organization_id/projects/:project_id',                to: 'projects#update'
    delete  'organizations/:organization_id/projects/:project_id',                to: 'projects#destroy'

    draw :users

    draw :galleries

    draw :communications

    # /source_controls
    namespace :source_controls do
      # /giteas
      get     'giteas',           to: 'giteas#index'
      get     'giteas/:gitea_id', to: 'giteas#show'
      post    'giteas',           to: 'giteas#create'
      put     'giteas/:gitea_id', to: 'giteas#update'
      delete  'giteas/:gitea_id', to: 'giteas#destroy'

      # /repositories
      get     'projects/:project_id/repositories',                to: 'repositories#index'
      get     'projects/:project_id/repositories/:repository_id', to: 'repositories#show'
      post    'projects/:project_id/repositories',                to: 'repositories#create'
      put     'projects/:project_id/repositories/:repository_id', to: 'repositories#update'
      delete  'projects/:project_id/repositories/:repository_id', to: 'repositories#destroy'
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
