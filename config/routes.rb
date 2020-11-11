Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => 'sidekiq'
  

  get 'auth/:provider/callback', to: 'admin/sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'admin/sessions#destroy', as: 'signout'

  get 'contact' => 'contacts#new'
  get 'contacts/create'
  get 'about' => 'about#index' 
  get 'posts/report'

  get 'users/created' => 'users#created', as: 'created'


  namespace :admin do
    get 'login' => 'sessions#new', as: 'login'
    get 'logout' => 'sessions#destroy', as: 'logout'
    get 'sessions/create'
  end
  namespace :admin do
    get 'users/new'
    get 'users/create'
    get 'users/update'
    get 'users/edit'
    get 'users/destroy'
    get 'users/index'
    get 'users/show'
  end
  namespace :admin do
    get 'comments/destroy'
  end
  get 'comments/new'
  namespace :admin do
    get 'categories/new'
    get 'categories/create'
    get 'categories/edit'
    get 'categories/update'
    get 'categories/destroy'
    get 'categories/index'
    get 'categories/show'
  end
  get 'categories/show'
  namespace :admin do
    get 'posts/new'
    get 'posts/create'
    get 'posts/edit'
    get 'posts/update'
    get 'posts/destroy'
    get 'posts/index'
    get 'posts/show'
  end
  get 'posts/index'
  get 'posts/show'

  resources :posts, :categories
  resources :users

  namespace :admin do
    resources :posts, :categories, :comments, :users, :sessions
  end

  resources :posts do
    resources :comments
  end
  
  root 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
