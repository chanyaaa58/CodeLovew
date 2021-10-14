Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, only: [:show]
  # root 'users#new'
  mount LetterOpenerWeb::Engine, at: "/mail_box" if Rails.env.development?
end