Rails.application.routes.draw do
  root to: "pages#home"

  resources :households, only: [:show]

  devise_for :users, :path_prefix => 'auth'
  resources :users, except: [:index]


  resources :menus, only: [:index, :show, :new] do
    resources :meals, only: [:index, :show] do
      resources :courses, only: [:new, :create, :show, :edit, :update, :destroy]
    end
  end

  resources :menus, only: [:show] do
    member do
      get '/:meal_type', to: 'menus#show_meal', as: 'show_meal'
    end
  end

  resources :meals, only: [:new, :create, :destroy] do
    collection do
      get 'meal_new'
      get 'planner'
      get 'multi_destroy', to: 'meals#multi_destroy', as: 'multi_destroy'
    end
  end


  resources :recipes, only: [:index, :show, :new] do
    collection do
      get 'recipe_search'
    end
  end

  resources :products, only: [:index]

  resources :groceries do
    collection do
      get 'multi_edit', to: 'groceries#multi_edit', as: 'multi_edit'
    end
  end


end
