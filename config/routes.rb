Rails.application.routes.draw do
  get '/index', to: 'main#index'
  root 'main#index'
end
