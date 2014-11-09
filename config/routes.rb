Comtijolo::Application.routes.draw do

  get '/signout', to: 'sessions#destroy'
  post '/signin', to: 'sessions#create'
  get '/signin', to: 'sessions#new'

  post '/signup', to: 'users#create'
  get '/signup', to: 'users#new'

  get '/casal', to: 'users#index'
  get '/contato', to: 'contact#index'
  get '/feed', to: 'posts#feed', as: :feed

  get :search, to: 'searches#new'

  resources :users
  resources :sessions    

  resources :password_resets, only: [:new, :create, :edit, :update]
  
  resources :posts, path: "", except: [:index, :new, :create] do
    patch :unrecommend, :recommend, on: :member
    get :archive, on: :collection
  end

  resources :posts, only: [:index, :new, :create]

  resources :attachments, only: [:create, :destroy, :update]
  resources :videos, only: [:create, :destroy, :update]

  get 'categories/autocomplete', to: 'categories#autocomplete'
  get 'collections/autocomplete', to: 'collections#autocomplete'
  get 'tags/autocomplete', to: 'tags#autocomplete'
  get 'posts/autocomplete', to: 'posts#autocomplete'

  resources :categories, only: [:show, :edit, :update]
  resources :collections, only: [:show, :edit, :update]
  resources :tags, only: :show

  get 'tags/:tag', to: 'categories#show'
  
  root to: 'posts#index' 

  get '*id', to: 'posts#index'

  match '/contact', to: 'contact#new',    via: :get
  match '/contact', to: 'contact#create', via: :post
end
