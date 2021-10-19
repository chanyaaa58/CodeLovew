Rails.application.routes.draw do
  root 'tops#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end

  resources :users, only: [:show]

  resources :reviews do
    resource :lovews, only: [:create, :destroy]
    resources :comments
    collection do
      get 'search'
    end
  end

  mount LetterOpenerWeb::Engine, at: "/mail_box" if Rails.env.development?
end