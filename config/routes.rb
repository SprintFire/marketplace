Rails.application.routes.draw do
  get 'search', to: 'search#index', as: 'search'
  get 'category/:id', to: 'category#show', as: 'category'

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

  resources :cards, only: [:create, :destroy]

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

end
