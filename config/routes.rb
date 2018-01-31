Rails.application.routes.draw do
  namespace :api do
    resources :cohorts, only: [:index, :update]
    resources :users
    resources :tags
  end

end
