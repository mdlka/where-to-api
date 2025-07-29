Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    scope module: :auth do
      post "signup", to: "auth#signup"
      post "login", to: "auth#login"
      delete "logout", to: "auth#logout"

      resources :api_keys, path: "tokens", only: [ :index ]
    end

    resources :places, only: [ :index, :show, :create, :update, :destroy ]
    resources :plans, only: [ :index, :show, :create, :update, :destroy ] do
      resources :places, only: [ :index, :show, :create, :destroy ], controller: :plan_places
    end
  end
end
