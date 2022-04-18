Rails.application.routes.draw do
  devise_for :users
  root to: 'repertoires#index'
  resources :repertoires, only: [:index, :new, :create]

end
