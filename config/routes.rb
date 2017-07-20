Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users
  end

  mount_devise_token_auth_for 'User', at: 'api',
    skip: [:registrations, :confirmations]
end
