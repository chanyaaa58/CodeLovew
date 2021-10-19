Rails.application.routes.draw do
  resources :labels
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
    collection do
      get 'search'
    end
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  mount LetterOpenerWeb::Engine, at: "/mail_box" if Rails.env.development?
end