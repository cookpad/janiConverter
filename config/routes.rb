require 'sidekiq/web'

Rails.application.routes.draw do
  resources :movies do
    collection do
      get "uuid/:uuid", action: :show
    end
  end

  mount Sidekiq::Web, at: '/sidekiq'

  root "movies#new"
end
