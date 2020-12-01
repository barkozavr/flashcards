Rails.application.routes.draw do
  root 'testers#index'
  resources :testers, only: %i[index create]
  resources :cards
  resources :users
  resources :user_sessions, only: %i[new create destroy]
  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

  scope '/oauth' do
    post 'callback', to: 'oauths#callback'
    get 'callback', to: 'oauths#callback'
    get ':provider', to: 'oauths#oauth', as: :auth_at_provider
  end
end
