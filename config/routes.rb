Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "overridden/registrations", invitations: "overridden/invitations" }

  root to: 'welcome#index'

  namespace :admin do
    resources :users
    resources :locations
    resources :camps do
      patch :update_status, on: :member
    end
    resources :camps_registrations
  end
  
  namespace :user do
    resources :camps do
      get :introduction, on: :member
    end
    resources :camps_registrations
    resources :users
  end

  namespace :api do
    namespace :v1 do
      resources :camps_registrations do
        
      end
    end
  end
end
