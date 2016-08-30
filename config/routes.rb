Rails.application.routes.draw do
  resources :posts
  devise_for :users
  root 'splash#index'
  
  resources :users
end
