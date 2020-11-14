Rails.application.routes.draw do
  devise_for :accounts, :controllers => {:registrations => "accounts"} 
    resources :accounts, :only => [:index, :show, :new, :create]
    resources :profiles, :only => [:index, :show, :update, :edit]
    resources :connections, :only => [:index, :show, :new, :create]
    resources :homes, :only => [:index]
    resources :conversations do
      resources :messages
    end
  root :to => "homes#index"
end
