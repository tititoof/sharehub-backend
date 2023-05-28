# /galleries
namespace :galleries do
  # /groups
  namespace :groups do
    # /albums
    get     '/:group_id/albums',            to: 'albums#index'
    get     '/:group_id/albums/:album_id',  to: 'albums#show'
    post    '/:group_id/albums',            to: 'albums#create'
    put     '/:group_id/albums/:album_id',  to: 'albums#update'
    delete  '/:group_id/albums/:album_id',  to: 'albums#destroy'

    # /media
    get     '/:group_id/albums/:album_id/media',              to: 'media#index'
    get     '/:group_id/albums/:album_id/media/:medium_id',   to: 'media#show'
    post    '/:group_id/albums/:album_id/media',              to: 'media#create'
    delete  '/:group_id/albums/:album_id/media/:medium_id',   to: 'media#destroy'
  end

  # /organizations
  namespace :organizations do
    # /albums
    get     '/:organization_id/albums',            to: 'albums#index'
    get     '/:organization_id/albums/:album_id',  to: 'albums#show'
    post    '/:organization_id/albums',            to: 'albums#create'
    put     '/:organization_id/albums/:album_id',  to: 'albums#update'
    delete  '/:organization_id/albums/:album_id',  to: 'albums#destroy'

    # /media
    get     '/:organization_id/albums/:album_id/media',              to: 'media#index'
    get     '/:organization_id/albums/:album_id/media/:medium_id',   to: 'media#show'
    post    '/:organization_id/albums/:album_id/media',              to: 'media#create'
    delete  '/:organization_id/albums/:album_id/media/:medium_id',   to: 'media#destroy'
  end

  # /users
  namespace :users do
    # /albums
    get     '/albums',            to: 'albums#index'
    get     '/albums/:album_id',  to: 'albums#show'
    post    '/albums',            to: 'albums#create'
    put     '/albums/:album_id',  to: 'albums#update'
    delete  '/albums/:album_id',  to: 'albums#destroy'

    # /media
    get     '/albums/:album_id/media',              to: 'media#index'
    get     '/albums/:album_id/media/:medium_id',   to: 'media#show'
    post    '/albums/:album_id/media',              to: 'media#create'
    delete  '/albums/:album_id/media/:medium_id',   to: 'media#destroy'
  end
end