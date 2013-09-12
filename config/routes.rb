Librarycat::Application.routes.draw do

  resources :copies


  resources :books


  root :to => 'pages#home'
  
end
