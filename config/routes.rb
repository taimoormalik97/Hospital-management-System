Rails.application.routes.draw do

  resources :doctors
  resources :patients
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :medicines do
  	collection do
      get 'search'
      get 'search_pred'
    end
  end

  resources :purchase_order do
    member do
      post 'addmed'
    end
  end
  root 'public_pages#index'
  get '/hospital/index', to: 'hospital#index'
  get 'find', to: 'public_pages#find'
  post 'find', to: 'public_pages#check_email', as: 'check_email'
  get '/find/select_domain', to: 'hospital#select_domain', as: 'select_domain'
  resources :admin, only: [:show, :edit, :update]
  resources :doctors
  resources :patients
  devise_for :users
end

