Rails.application.routes.draw do
  root to: "pages#home"

  resources :households, only: [:show]

  devise_for :users, :path_prefix => 'auth'
  resources :users, only: [:new, :create]


  resources :menus, only: [:index, :show, :new, :create] do
    resources :meals, only: [:show, :edit, :update, :destroy]
  end

  resources :meals, only: [:new, :create] do
    # collection do
    #   get :meal_new
    # end
  end

  resources :courses, only: [:new, :create]

  resources :recipes, only: [:index,:show, :new]




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
