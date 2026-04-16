Rails.application.routes.draw do
  namespace :api do
    post "signup", to: "auth#signup"
    post "login", to: "auth#login"

    resources :projects, only: [:index, :create, :show] do
      resources :review_sessions, only: [:create]
    end

    resources :review_sessions, only: [:show] do
      resources :comments, only: [:index, :create]
    end

    resources :comments, only: [:update]
  end

  get "review/:share_token", to: "public/reviews#show"
end