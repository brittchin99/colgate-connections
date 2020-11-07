Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :connections, only: [:index, :show]
  resources :accounts
  root "connections#index"
end
