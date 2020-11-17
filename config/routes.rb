Rails.application.routes.draw do
  get '/index', to: 'main#index'
  root 'main#index'
  resources :cards, only: %i[index new create show]
end
