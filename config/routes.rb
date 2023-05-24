Rails.application.routes.draw do
  defaults format: :json do
    # get 'ticket_types/index'
    # get 'ticket_types/destroy'
    # get 'ticket_types/create'
    # get 'ticket_types/update'
    resources :ticket_types, controller: 'ticket_types', except: %i[index create]
    devise_for :users
    resources :users do
      collection do
        get :me, controller: 'users/users'
        get '/:id/tickets', action: :tickets, controller: 'users/users'
      end
    end
    resources :users, controller: 'users/users', only: %i[index show]
    resources :events do
      collection do
        post '/:id/buy', action: :buy
        get '/:id/tickets', action: :tickets
        get '/:event_id/ticket_types', action: :index, controller: 'ticket_types'
        post '/:event_id/ticket_types', action: :create, controller: 'ticket_types'
      end
    end
    resources :producers
  end
end
