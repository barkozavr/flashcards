Rails.application.routes.draw do
  get '/index', to: 'mail#index'
  root 'main#index'
end
