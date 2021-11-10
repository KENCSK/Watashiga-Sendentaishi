Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root to: 'homes#top'

  get '/search', to: 'searches#search'


  get '/my_page' => 'users#my_page'
  resources :users, except: [:new]

  resources :posts do
    resource :charms, only:[:index, :create, :destroy]
  end


end
