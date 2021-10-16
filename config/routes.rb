Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'tops#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :tops
  resources :users, only: [:show]
  resources :reviews do
    resources :comments
  end
  mount LetterOpenerWeb::Engine, at: "/mail_box" if Rails.env.development?
end