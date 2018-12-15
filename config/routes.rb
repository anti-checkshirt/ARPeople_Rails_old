Rails.application.routes.draw do


  get 'sessions/new'
  get 'sessions/creare'
  get 'sessions/destroy'
  resources :users
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
end
