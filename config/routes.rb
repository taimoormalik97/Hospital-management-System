Rails.application.routes.draw do
  resources :bills do
    member do
      post 'add_medicine'
      post 'add_doctor'
      get 'get_medicine'
    end
  end
  resources :doctors do
    collection do
      get 'search_pred'
      get 'search'
    end
  end
  resources :patients do
    collection do
      get 'search_pred'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :medicines do
    collection do
      get 'search_pred'
    end
  end

  resources :purchase_order do
    member do
      post 'add_medicine'
      put 'confirm'
      put 'deliver'
      get 'get_medicine'
    end
  end
  root 'public_pages#index'
  get 'about', to: 'public_pages#about'
  get 'contact', to: 'public_pages#contact'
  get '/hospital/index', to: 'hospital#index'
  get 'find', to: 'public_pages#find'
  post 'find', to: 'public_pages#check_email', as: 'check_email'
  get '/find/select_domain', to: 'hospital#select_domain', as: 'select_domain'
  resources :admin, only: [:show, :edit, :update]
  resources :appointments do
    collection do
      get 'show_availabilities'
    end
    member do
      put 'approve'
      put 'complete'
      put 'cancel'
    end
  end
  resources :doctors do
    resources :availabilities, except: [:edit, :update, :show]
    collection do
      post 'speciality_filter'
    end
  end
  resources :patients
  get 'dashboard' => 'dashboards#dashboard' 
  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords', sessions: 'users/sessions', confirmations: 'users/confirmations' }
  
  match '*unmatched', to: 'application#route_not_found', via: :all
end
