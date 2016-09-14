Rails.application.routes.draw do
  resources :posts
  devise_for :users
  root 'splash#index'
  
  resources :users
  
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :users, except: [:new, :edit]
    end
  end
end
