Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'

  get '/search', to: 'searches#search'


  get '/mypage' => 'users#mypage'
  resources :users, except: [:new]

  resources :posts do
    resource :charms, only:[:index, :create, :destroy]
  end


end
