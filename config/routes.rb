Rails.application.routes.draw do
  root to: "pages#home"

  resources :households, only: [:show]

  devise_for :users, :path_prefix => 'auth'
  resources :users, except: [:index]


  resources :menus, only: [:index, :show] do
    resources :meals, only: [:index, :show] do
      resources :courses, only: [:new, :create, :show, :edit, :update, :destroy] do
        collection do
          get 'search'
        end
      end
    end
  end

  #  To be removed - used as testing for modal and multi-obj creation
  resources :meals, only: [:new, :create]



  resources :recipes, only: [:index, :show, :new]




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
