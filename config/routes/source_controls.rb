# /source_controls
namespace :source_controls do
  # /giteas
  get     'organizations/:organization_id/giteas',           to: 'giteas#index'
  get     'organizations/:organization_id/giteas/:gitea_id', to: 'giteas#show'
  post    'organizations/:organization_id/giteas',           to: 'giteas#create'
  put     'organizations/:organization_id/giteas/:gitea_id', to: 'giteas#update'
  delete  'organizations/:organization_id/giteas/:gitea_id', to: 'giteas#destroy'

  # /repositories
  get     'projects/:project_id/repositories',                to: 'repositories#index'
  get     'projects/:project_id/repositories/:repository_id', to: 'repositories#show'
  post    'projects/:project_id/repositories',                to: 'repositories#create'
  put     'projects/:project_id/repositories/:repository_id', to: 'repositories#update'
  delete  'projects/:project_id/repositories/:repository_id', to: 'repositories#destroy'
end