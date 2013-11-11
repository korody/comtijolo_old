Comtijolo::Application.routes.draw do

  delete '/signout', to: 'sessions#destroy'
  post '/signin', to: 'sessions#create'
  get '/signin', to: 'sessions#new'

  post '/signup', to: 'users#create'
  get '/signup', to: 'users#new'

  resources :users

  resources :password_resets, only: [:new, :create, :edit, :update]
  
  resources :posts, path: "", except: [:index, :new, :create]

  resources :posts, only: [:index, :new, :create] do
    resources :attachments, only: [:create, :destroy, :update]
    resources :videos, only: [:create, :destroy, :update]
  end

  resources :attachments, only: [:create, :destroy, :update]
  resources :videos, only: [:create, :destroy, :update]

  get 'categories/autocomplete', to: 'categories#autocomplete'
  get 'tags/autocomplete', to: 'tags#autocomplete'

  resources :categories
  resources :tags, only: [:index, :show]

  # get 'tags/:tag', to: 'posts#index', as: :tag
  get 'tags/:tag', to: 'categories#show'
  
  match '/contact', to: 'contact#new',    via: :get
  match '/contact', to: 'contact#create', via: :post

  root to: 'posts#index' 

  get '*id', to: 'posts#index'
end
