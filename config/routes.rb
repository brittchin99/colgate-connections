Rails.application.routes.draw do
  get 'accounts/new'
  devise_for :accounts, :controllers => {:registrations => "accounts"}
    resources :accounts, :only => [:index, :show, :new, :create]
    resources :connections, :only => [:index, :show, :new, :create]
    root :to => "connections#index"
end
