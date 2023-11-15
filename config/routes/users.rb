# /users
namespace :users do
  # /profiles
  get   '/profiles',               to: 'profiles#index'
  get   '/profiles/list',          to: 'profiles#list'
  get   '/profiles/show-avatar',   to: 'profiles#show_avatar'
  get   '/profiles/:profile_id',   to: 'profiles#show'
  post  '/profiles',               to: 'profiles#save'
  post  '/profiles/upload-avatar', to: 'profiles#upload_avatar'

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