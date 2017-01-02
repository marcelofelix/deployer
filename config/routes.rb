Rails.application.routes.draw do
  resources :projects
  resources :environments
  resources :versions
end
