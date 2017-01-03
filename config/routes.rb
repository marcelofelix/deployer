Rails.application.routes.draw do
  resources :projects
  resources :environments
  resources :versions
  post '/versions/:id/deploy', to: 'versions#deploy'
end
