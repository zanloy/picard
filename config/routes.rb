Rails.application.routes.draw do

  get 'api/add-cert'

  root to: 'engineering_changes#index'

  get 'changes/quickadd', to: 'engineering_changes#quickadd'
  resources :engineering_changes, path: 'changes' do
    resources :comments, path: 'c', only: :create
    resources :subscriptions, path: 'subscribe', only: :create
  end
  resources :environments
  resources :certificates
  resources :lists do
    resources :alerts, shallow: true, except: [:index, :show, :edit, :update]
    resources :list_items, shallow: true, except: [:index, :show]
  end
  resources :users do
    get 'generate_apikey', to: 'users#generate_apikey'
  end
  resources :comments, only: :destroy
  resources :subscriptions, only: [:index, :destroy]
  resources :sessions, only: [:login, :create, :destroy]

  resources :tags, only: [:index, :show]
  #get 'tags', to: 'tags#index'
  #get 'tags/:name', to: 'tags#show', as: :tag

  get 'admin', to: 'admin#index'
  get 'admin/enable_user/:user_id', to: 'admin#enable_user', as: :enable_user

  # API
  post 'api/add_cert', to: 'api#add_cert'
  
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signin', to: 'sessions#login', as: 'signin'
  get 'sessions/login'
  post 'sessions/login_attempt'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'signup', to: 'users#new', as: 'signup'
  get 'disabled', to: 'sessions#disabled', as: 'disabled'

  post 'webhooks/slack'

end
