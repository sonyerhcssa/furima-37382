Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users
  root to: "items#index"

  resources :items do
    resources :purchases, only:[:index, :create]
    resources :comments,  only:[:create]
    collection do
      get 'search'
    end
  end

  resources :cards, only: [:new, :create]
  resources :users, only: [:show]

end