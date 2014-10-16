require 'sidekiq/web'

Rails.application.routes.draw do
  resources :movies

  mount Sidekiq::Web, at: '/sidekiq'

  root "movies#new"
end
