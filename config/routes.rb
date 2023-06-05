Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users, :path_prefix => 'auth'
  resources :users, only: [:new, :create]

  resources :households, only: [:show]

  resources :menus, only: [:index, :show, :new, :create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
