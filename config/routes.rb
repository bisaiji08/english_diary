Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root to: 'static_pages#top'

  get 'mypages/top', to: 'mypages#top', as: 'mypages_top'

  get 'mypages/diaries', to: 'diaries#index', as: 'mypages_diaries'

  resources :diaries do
    post 'translate', on: :collection
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end