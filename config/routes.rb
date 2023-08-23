Rails.application.routes.draw do

  resources :expense_reports do
    collection do
      get 'search'
    end
    resources :comments
  end

  # resources :expense_report, only: %i[new create show]
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }

  # get 'pages/users'
  get 'pages/admin'
  resources :expenses do
    collection do
      get 'search'
    end
    resources :comments 
    member do
      patch 'approve'
      patch 'reject'
    end
  end
  resources :pages do
    member do
      patch 'terminate'
      patch 'activate'
    end
  end

  root to: 'pages#home'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
