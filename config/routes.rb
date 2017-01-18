Rails.application.routes.draw do
  resources :projects
  resources :environments
  get '/projects/:id/versions', to: 'projects#versions'
  post '/environments/:id/replace', to: 'environments#add_replace'
  post '/environments/:id/deploy', to: 'environments#deploy'
  delete '/environments/replace/:id', to: 'environments#remove_replace'
  root to: 'projects#index'
end
