Rails.application.routes.draw do
  namespace :api do
    post "signup", to: "auth#signup"
    post "login", to: "auth#login"
    get "me", to: "auth#me"
    patch "password", to: "auth#update_password"
    post "forgot_password", to: "auth#forgot_password"
    patch "reset_password", to: "auth#reset_password"

    resources :projects, only: [:index, :create, :show] do
      resources :review_sessions, only: [:create]
    end

    resources :review_sessions, only: [:index, :show, :destroy, :update] do
      resources :comments, only: [:index, :create, :update, :destroy]
  end
end
  get "review/:slug", to: "public/reviews#show"

  mount ActionCable.server => "/cable"
end