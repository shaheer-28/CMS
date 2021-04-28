Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", invitations: "users/invitations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'

  namespace :admin do
    resources :users
    resources :locations
    resources :camps do
      patch :update_status, on: :member  
    end
  end
  
  resources :users
end
