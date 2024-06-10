Rails.application.routes.draw do
  root to: "pages#home"

  resources :households, only: [:show]

  devise_for :users, :path_prefix => 'auth'
  resources :users, except: [:index]

  resources :menus, only: [:index, :show, :new] do
    resources :meals, only: [:show] do
      resources :courses, only: [:destroy]
    end
  end

  resources :menus, only: [] do
    member do
      get ':meal_type', to: 'menus#show_meal', as: 'show_meal'
    end
  end

  resources :courses, only: [:index] do
    collection do
      post 'create', to: 'courses#create', as: 'create'
      delete 'multi_destroy', to: 'courses#multi_destroy', as: 'multi_destroy'
    end
  end

  resources :planners, only: [:index, :new, :create]

  resources :recipes, only: [:index, :show] do
    collection do
      get 'recipe_search'
    end
  end

  resources :fetch_recipes, only: [:index] do
    post 'search'
  end

  resources :groceries, only: [:index, :new, :create] do
    collection do
      patch 'edit_multiple', to: 'groceries#edit_multiple', as: 'edit_multiple'
    end
  end

  resources :products, only: [:index]
end
