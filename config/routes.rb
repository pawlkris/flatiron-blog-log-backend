Rails.application.routes.draw do
  namespace :api do
    resources :cohorts, only: [:index, :update, :show]
    resources :users
    resources :tags
    resources :posts
    post '/auth', to: 'auth#create'
    get '/current_user', to: 'auth#show'
  end

end
