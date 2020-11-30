Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  root 'testers#index'
  resources :testers, only: %i[index create]
  resources :cards
  resources :users
  resources :user_sessions, only: %i[new create destroy]
  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
