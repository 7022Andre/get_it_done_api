Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users do
      resources :lists
    end

    resources :lists, only: [] do
      resources :items, only: [:create]
    end

    resources :items, only: [:destroy]
  end

  mount_devise_token_auth_for 'User', at: 'api',
    skip: [:registrations, :confirmations]
end
