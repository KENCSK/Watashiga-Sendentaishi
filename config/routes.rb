Rails.application.routes.draw do
  get 'prefectures/index'
  get 'prefecture/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root to: 'homes#top'
  get 'posts/search', to: 'posts#search'
  get '/my_page' => 'users#my_page'
  resources :users, except: [:new] do
    collection do
      get :charms
    end
  end
  resources :prefectures, only: [:index]
  resources :posts do
    resource :charms, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
