Rails.application.routes.draw do
  devise_for :users
  root to: 'repertoires#index'
  
  resources :repertoires do
    resources :ingredients, except: [:index]
      collection do
        get 'search'
      end
  end

  resources :cooking_hacks, only: [:new, :create]
    

end
