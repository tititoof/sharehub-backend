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
      get 'countries',          to:'country#index'
      # States
      get 'states/:country_id', to: 'state#index'
      # Cities
      get 'cities/:state_id',   to: 'city#index'
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
