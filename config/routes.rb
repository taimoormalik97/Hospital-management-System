Rails.application.routes.draw do

  root 'public_pages#index'
  get '/hospital/index', to: 'hospital#index',  as: 'hospital_index'
  get 'find', to: 'public_pages#find'
  post 'find', to: 'public_pages#check_email', as: 'check_email'
  get '/find/select_domain', to: 'hospital#select_domain', as: 'select_domain'
  resources :admin, only: [:show, :edit, :update]
  devise_for :users, :controllers => { sessions: 'users/sessions', registrations: 'users/registrations' }, path: 'users'
  resources :doctors
  resources :patients
  get 'dashboard' => 'dashboards#dashboard' 
end
