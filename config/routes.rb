Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "overridden/registrations", invitations: "overridden/invitations" }

  root to: 'welcome#index'

  namespace :admin do
    resources :users
    resources :locations
    resources :camps do
      patch :update_status, on: :member  
    end
  end
  
  namespace :user do
    resources :camps do
      get :introduction, on: :member
    end
    resources :camps_registrations
    resources :users
  end
end
