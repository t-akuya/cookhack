Rails.application.routes.draw do
  devise_for :users
  root to: 'repertoires#index'
  
  resources :repertoires do
    resource :likes, only: [:create, :destroy]
    resources :ingredients, except: [:index]
      collection do
        get 'search'
      end
  end

  resources :cooking_hacks do
    resource :like_hacks, only: [:create, :destroy]
  end

   resources :users, only: [:show] do
    member do
      get :likes, :like_hacks
    end
  end

end
