Rails.application.routes.draw do

  devise_for :users, path: "", path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'reset_password',
    confirmation: 'verification',
    unlock: 'unlock',
    sign_up: 'join'
  },
  :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  get "account", to: 'users#edit', as: :account
  patch "account", to: 'users#update'
  delete "delete_card", to: "users#delete_card", as: "delete_card"

  root 'pages#home'

  resources :shops do
    resources :withdrawals, only: [:new, :create]
    @shops = Shop.all
    resources :products do
    end
  end


namespace :dashboard do
  get "/" => "/pages#dashboard", as: "/"
  get "my_shops" => "/shops#my_shops", as: "my_shops"
  get "purchases" => "/purchases#index", as: "purchase_history"
  get "withdrawals", to: "/withdrawals#index", as: "withdrawals"
end


  # get "checkout/:id", to: "purchases#show", as: "checkout"
  # post "checkout/:id", to: "purchases#create"

  get 'checkout/:id', to: "checkouts#new", as: "checkout"
  post "checkout/:id", to: "checkouts#checkout_new_card"
  post "checkout_current_card", to: "checkouts#checkout_current_card", as: "checkout_current_card"

  mount Commontator::Engine => '/commontator'
  post '/rate' => 'rater#create', :as => 'rate'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "errors/not_found"
  get "errors/internal_server_error"

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

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
