Rails.application.routes.draw do
  resources :projects do
    resources :environments, shallow: true do
      resources :replaces, shallow: true
    end
    resources :versions, shallow: true
  end
  resources :deploy, only: :index
  post '/deploy', to: 'deploy#deploy'

  get '/projects/:project_id/versions/sync', to: 'versions#sync'
  post '/projects/:project_id/versions/sync', to: 'versions#sync'

  post '/replaces', to: 'environments#add_replace'
  delete '/replaces/:id', to: 'environments#remove_replace'

  post '/environments/:id/deploy', to: 'environments#deploy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', :as => :signout
  root to: 'home#index'
end
