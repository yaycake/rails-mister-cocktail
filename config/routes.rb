Rails.application.routes.draw do
  get 'doses/index'

  root to: "cocktails#index"
  resources :cocktails, except: [:edit, :destroy] do
    resources :doses, only: [:new, :create]
  end
    resources :doses, only: [:show, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
