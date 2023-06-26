Rails.application.routes.draw do
  resources :posts do
    collection do
      post :confirm
    end
  end

  resources :posts do
    resources :favorites, only: [:create, :destroy]
  end

  get '/favorites', to: 'favorites#index'
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :sessions, only: [:new, :create, :destroy]
  resources :users 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


