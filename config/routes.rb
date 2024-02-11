Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#new"
  post 'home/create', to: 'home#create', as: 'create_event'
  post 'events/create_event', to: 'events#create_event'
  post 'emails/create', to: 'emails#create', as: 'send_email'
  resources :admin
end
