Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resource :session, only: %i(show create destroy)
    resources :users

    get "/search", to: 'search#index'
  end

  get "*path" => "application#index"
  root to: "application#index"


end
