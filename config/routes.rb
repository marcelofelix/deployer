Rails.application.routes.draw do
  resources :projects
  resources :environments
  post '/environments/:id/replace', to: 'environment#add_replace'
  root to: 'projects#index'
end
