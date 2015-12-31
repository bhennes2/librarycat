Librarycat::Application.routes.draw do

  devise_for :users

  resources :copies
  resources :books do
    resources :copies
  end
  resources :tags
  root :to => 'pages#home'
  
  post '/search' => 'pages#search', as: :search
  
end
