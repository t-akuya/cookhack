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

  resources :cooking_hacks

   resources :users, only: [:show] do
    member do
      get :likes
    end
  end

end
