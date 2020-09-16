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
end

