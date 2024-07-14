# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  namespace :api do
    namespace :v1 do
      post 'register', to: 'register#create'
      post 'login', to: 'auth#login'
      post 'settings', to: 'auth#settings'
      delete 'logout', to: 'auth#logout'

      post 'user/new', to: 'users#create'
      post 'category/new', to: 'categories#create'
    end
  end
end
