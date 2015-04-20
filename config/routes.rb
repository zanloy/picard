Rails.application.routes.draw do

  root 'log_items#index'

  resources :log_items, path: 'log' do
    resources :comments, path: 'c', only: [:create, :edit, :update, :destroy]
    resources :subscriptions, path: 'subscribe', only: :create
  end
  resources :servers
  resources :environments
  resources :comments
  resources :profiles
  resources :users
  resources :subscriptions, only: [:index, :destroy]
  resources :sessions, only: [:login, :create, :destroy]

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signin', to: 'sessions#login', as: 'signin'
  get 'sessions/login'
  post 'sessions/login_attempt'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'signup', to: 'users#new', as: 'signup'
  get 'disabled', to: 'sessions#disabled', as: 'disabled'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
