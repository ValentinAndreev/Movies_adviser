Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { sessions: "custom_sessions", omniauth_callbacks: "callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :movies do
    resources :comments
  end
end
