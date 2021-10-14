Rails.application.routes.draw do
  root 'users#new'
  mount LetterOpenerWeb::Engine, at: "/mail_box" if Rails.env.development?
end
