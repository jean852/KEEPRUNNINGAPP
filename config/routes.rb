Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  root to: "pages#home"

  resources :challenges, only: [:create, :index, :new, :update, :edit, :show, :destroy]
  resources :activities, only: [:index]
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
  end

  get "dashboard", to: "pages#dashboard", as: :user_root # creates user_root_path
  get "leaderboard", to: "pages#leaderboard"
  get "webhook", to: "pages#webhook"
  post "webhook", to: "pages#handle_activities"

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
