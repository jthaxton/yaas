Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
  post '/sessions/create', to: 'sessions#create'
  get '/sessions/show', to: 'sessions#show'
  post '/sessions/destroy', to: 'sessions#destroy'
  post '/registrations/create', to: 'registrations#create'
end
