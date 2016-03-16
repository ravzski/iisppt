Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resource :session, only: %i(show create destroy) do
      collection do
        post :register
      end
    end
    resources :users
    resources :markers
    resources :route_ratings
    resources :searches
    resources :alerts
    resources :user_alerts
    resources :directions
    resources :legs
    get "/search", to: 'search#index'

  end

  get "*path" => "application#index"
  root to: "application#index"


end
