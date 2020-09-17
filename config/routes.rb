Rails.application.routes.draw do

  root 'public_pages#index'
  get '/hospital/index', to: 'hospital#index'
  get 'find', to: 'public_pages#find'
  post 'find', to: 'public_pages#check_email', as: 'check_email'
  get '/find/select_domain', to: 'hospital#select_domain', as: 'select_domain'
  resources :admin, only: [:show, :edit, :update]
  resources :doctors
  resources :patients
  get 'dashboard' => 'dashboards#dashboard' 
  devise_for :users
end
