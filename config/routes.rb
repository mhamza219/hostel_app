Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  post 'residents/signup', to: 'residents#signup'
  post 'residents/login', to: 'residents#login'
  resources :hostels
  resources :rooms
end
