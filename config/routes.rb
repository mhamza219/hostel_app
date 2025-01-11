Rails.application.routes.draw do
  get 'bookings/index'
  get 'bookings/show'
  get 'rooms/index'
  get 'rooms/show'
  get 'hostels/index'
  get 'hostels/show'
  get 'residents/index'
  get 'residents/new'
  get 'residents/create'
  get 'residents/show'
  get 'residents/update'
  get 'residents/destroy'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
