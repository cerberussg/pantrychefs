Rails.application.routes.draw do
  
  # Index root path
  root "pages#home"
  # Setting get of pages/home with controller
  get 'pages/home', to: 'pages#home'
  
  # Nested routes Recipes and then Comments inside
  resources :recipes do
    resources :comments, only: [:create]
  end
  
  # Signup path with Chefs controller
  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]
  
  # Session Controller routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # Ingredient route minus the destroy action in Fixings controller
  resources :fixings, except: [:destroy]
  
  # Setting up Action Cable server
  mount ActionCable.server => '/cable'
  
  get '/chat', to: 'chatrooms#show'
  resources :messages, only: [:create]
end
