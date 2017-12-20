Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { sessions: "custom_sessions", omniauth_callbacks: "callbacks" }
  devise_scope :user do
    resources :users, only: [ :show, :index ] do
      member do
        get :following, :followers
      end
    end
  end
  root 'home#index'
  resources :movies do
    resources :comments
    get 'recommendations', on: :member
  end
  resource :votes, only: :update
  resources :reviews do
    resources :comments
  end
  resources :relationships, only: [ :create, :destroy ]
end
