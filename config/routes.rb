Rails.application.routes.draw do
  resources :posts do
    collection do
      post :confirm
    end
    resources :favorites, only: [:create, :destroy]
  end

  get '/favorites', to: 'favorites#index'
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :sessions, only: [:new, :create, :destroy]
  resources :users 
  get 'new', to: 'controller#action'
  root "posts#index"
end