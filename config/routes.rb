Rails.application.routes.draw do
  root 'tops#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users
  resources :tops
  mount LetterOpenerWeb::Engine, at: "/mail_box" if Rails.env.development?
end