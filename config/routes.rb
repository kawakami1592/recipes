Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'
  resources :users, only: [:edit, :update, :show]

  resources :recipes do

    collection do
      # カテゴリーの階層分けのルート
      get 'category_children', defaults: { format: 'json' }
      get 'category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'list_by_category'
    end

    resources :likes, only: [:create, :destroy]
  end

  resources :ingredients, only: [:destroy]
  
end
