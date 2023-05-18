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
    get     'organizations',                  to: 'organizations#index'
    get     'organizations/:organization_id', to: 'organizations#show'
    post    'organizations',                  to: 'organizations#create'
    put     'organizations/:organization_id', to: 'organizations#update'
    delete  'organizations/:organization_id', to: 'organizations#destroy'

    # /users
    namespace :users do
      # /profiles
      get   '/profiles',              to: 'profiles#index'
      get   '/profiles/list',         to: 'profiles#list'
      get   '/profiles/:profile_id',  to: 'profiles#show'
      post  '/profiles',              to: 'profiles#save'

      # /groups
      get     '/groups',                          to: 'groups#index'
      post    '/groups',                          to: 'groups#create'
      get     '/groups/list',                     to: 'groups#list'
      post    '/groups/:group_id/add-member',     to: 'groups#add_member'
      post    '/groups/:group_id/remove-member',  to: 'groups#remove_member'
      get     '/groups/:group_id',                to: 'groups#show'
      put     '/groups/:group_id',                to: 'groups#update'
      delete  '/groups/:group_id',                to: 'groups#destroy'
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
