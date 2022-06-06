Rails.application.routes.draw do
  devise_for :users
  root to: 'repertoires#index'
  
  resources :repertoires do
    resources :ingredients
      collection do
        get 'search'
      end
  end
    

end
