Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Replace with your actual routes, but using Rails 5.2 syntax
  devise_for :users
  
  # Example resource routes
  # resources :products
  # resources :categories
  
  # Example of custom routes
  # get 'about', to: 'pages#about'
  # post 'contact', to: 'pages#contact'
  
  # Root path
  root to: 'home#index'
end