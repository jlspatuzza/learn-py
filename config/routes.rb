Rails.application.routes.draw do

  # config/routes.rb
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  root to: "pages#home"

  get "about", to: "pages#about"

  get "courses", to: "courses#index"

  get "courses/new", to: "courses#new"

  post "courses", to: "courses#create"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
