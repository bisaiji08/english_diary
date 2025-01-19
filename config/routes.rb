Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get '/auth/failure', to: 'users/omniauth_callbacks#failure'
    get '/users/connect/google', to: 'users/omniauth_callbacks#connect_google', as: 'connect_google'
    delete '/users/disconnect/google', to: 'users#disconnect_google', as: 'disconnect_google'
  end

  root to: 'static_pages#top'

  get 'mypages/top', to: 'mypages#top', as: 'mypages_top'
  get 'mypages/settings', to: 'mypages#settings', as: 'mypages_settings'
  get 'mypages/google_account', to: 'mypages#google_account', as: 'mypages_google_account'

  get 'mypages/notification_settings', to: 'mypages#notification_settings', as: 'mypages_notification_settings'
  patch 'mypages/update_notification_settings', to: 'mypages#update_notification_settings', as: 'update_notification_settings'

  get 'mypages/diaries', to: 'diaries#index', as: 'mypages_diaries'

  get 'mypages/how_to_use', to: 'mypages#how_to_use', as: :mypages_how_to_use

  resources :diaries do
    post 'translate', on: :collection
    get 'search', on: :collection
  end

  get 'trees', to: 'trees#index'
  post "create_tree", to: "trees#create"
  post "train", to: "trees#train"

  resources :shop, only: [:index, :show] do
    post 'purchase', on: :member
  end

  get 'terms', to: 'pages#terms', as: :terms
  get 'privacy', to: 'pages#privacy', as: :privacy
  get 'contact', to: 'pages#contact', as: :contact
  post 'contact', to: 'pages#contact'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
