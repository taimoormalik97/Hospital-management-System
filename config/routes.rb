Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :medicines do
  	collection do
      get 'search'
    end
  end
  
  resources :purchase_order do
    member do
      post 'addmed'
    end
end
end

