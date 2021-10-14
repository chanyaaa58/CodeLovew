Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root 'users#new'
  mount LetterOpenerWeb::Engine, at: "/mail_box" if Rails.env.development?
end