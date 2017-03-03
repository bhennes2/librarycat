Librarycat::Application.routes.draw do

  devise_for :users

  resources :copies
  resources :books do
    resources :copies
  end
  resources :tags
  root :to => 'pages#home'

  post '/search' => 'pages#search', as: :search
  get '/search' => 'pages#search'
  post '/letter_search' => 'pages#letter_search', as: :letter_search
  get '/letter_search' => 'pages#letter_search'

end
