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


  resources :users, only: [:show]

end
