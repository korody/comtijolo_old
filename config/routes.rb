Comtijolo::Application.routes.draw do

  delete '/signout', to: 'sessions#destroy'
  post '/signin', to: 'sessions#create'
  get '/signin', to: 'sessions#new'

  post '/signup', to: 'users#create'
  get '/signup', to: 'users#new'

  resources :users

  resources :password_resets, only: [:new, :create, :edit, :update]
  
  resources :posts do
    resources :attachments, only: [:create, :destroy, :update]
    resources :videos, only: [:create, :destroy, :update]
  end

  resources :categories
  resources :tags

  # get 'tags/:tag', to: 'posts#index', as: :tag

  get '/tijolo',   to: 'posts#index', as: 'tijolo'
  
  match '/contact', to: 'contact#new',    via: :get
  match '/contact', to: 'contact#create', via: :post

  root to: 'posts#index' 

end
