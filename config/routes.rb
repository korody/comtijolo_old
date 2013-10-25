Comtijolo::Application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :posts do
    resources :attachments, only: [:create, :destroy]
  end

  resources :categories
  resources :tags

  # get 'tags/:tag', to: 'posts#index', as: :tag

  get '/tijolo',   to: 'posts#index', as: 'tijolo'
  
  match '/contact', to: 'contact#new',    via: :get
  match '/contact', to: 'contact#create', via: :post

  root to: 'posts#index' 

end
