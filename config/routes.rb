require 'sidekiq/web'

Rails.application.routes.draw do
  resources :movies do
    collection do
      get "external_creative/:external_creative_id", to: "movies#show", as: :external_creative
      get "uuid/:uuid", to: "movies#show", as: :uuid
    end
  end

  mount Sidekiq::Web, at: '/sidekiq'

  root "movies#new"
end
