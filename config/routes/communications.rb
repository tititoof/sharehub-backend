# /communications
namespace :communications do
  # /groups
  namespace :groups do
    # /messages
    get     '/:group_id/conversations/:conversation_id/messages', to: 'messages#index'
    post    '/:group_id/conversations/:conversation_id/messages', to: 'messages#create'

    # /conversations
    get     '/:group_id/conversations',                   to: 'conversations#index'
    post    '/:group_id/conversations',                   to: 'conversations#create'
    put     '/:group_id/conversations/:conversation_id',  to: 'conversations#update'
    delete  '/:group_id/conversations/:conversation_id',  to: 'conversations#destroy'
  end

  # /users
  namespace :users do
    # /messages
    get     '/conversations/:conversation_id/messages', to: 'messages#index'
    post    '/conversations/:conversation_id/messages', to: 'messages#create'

    # /conversations
    get     '/conversations',                   to: 'conversations#index'
    post    '/conversations',                   to: 'conversations#create'
    put     '/conversations/:conversation_id',  to: 'conversations#update'
    delete  '/conversations/:conversation_id',  to: 'conversations#destroy'
  end
end