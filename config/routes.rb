Rails.application.routes.draw do
  get 'sessions/new'
  
  resources :posts do
    collection do
      post :confirm
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
