Librarycat::Application.routes.draw do

  resources :copies
  resources :books
  resources :tags
  root :to => 'pages#home'
  
  post '/search' => 'pages#search', as: :search
  
end
