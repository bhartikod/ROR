Rails.application.routes.draw do
  root 'posts#index'
  get 'welcome/home' 

  devise_for :users, controllers: {
        sessions: 'users/sessions' 
        
      }
   resources :profiles
  # resources :posts do
  #   member do
  #     get :like
  #   end
  # 	resources :comments
    
  # end
  # resource :comments, only: [] do
  #   member do 
  #    get :like
  #   end
  # end
   
  resources :posts do 
    member do 
      get :like
    end
    resources :comments, only: [:index, :new, :create]
  end
  #resources :comments, only: [:edit, :show, :update, :destroy]
  resources :comments, except: [:index, :new, :create] do 
    member do 
      get :like
    end
  end
  #root 'posts#index'
end
