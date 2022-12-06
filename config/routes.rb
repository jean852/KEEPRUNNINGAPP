Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  root to: "pages#home"

  resources :challenges, only: [:create, :index, :new, :update, :edit, :show, :destroy]
  resources :activities, only: [:index]
  get "dashboard", to: "page#dashboard"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
