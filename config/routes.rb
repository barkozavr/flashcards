Rails.application.routes.draw do
  root 'testers#index'
  resources :testers, only: [:index, :create]
  resources :cards
end