Rails.application.routes.draw do
  # Users routes
  resources :users, only: [:show]
  devise_scope :user do
    patch 'users/:id', to: 'users#update'
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'
  end
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  # Events routes
  resources :events
end
