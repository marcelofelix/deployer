Rails.application.routes.draw do
  resources :projects do
    resources :environments
  end
  resources :deploy, only: :index
  post '/deploy', to: 'deploy#deploy'

  get '/projects/:id/versions', to: 'projects#versions'

  post '/replaces', to: 'environments#add_replace'
  delete '/replaces/:id', to: 'environments#remove_replace'

  post '/environments/:id/deploy', to: 'environments#deploy'
  root to: 'projects#index'
end
