Rails.application.routes.draw do
  namespace :api do
    resources :cohorts, only: [:index, :update, :show]
    resources :users
    resources :tags
    resources :posts
    resources :fan_posts, only: [:show, :destroy, :create]
    post '/login', to: 'auth#create'
    get '/current_user', to: 'auth#show'
  end

end
