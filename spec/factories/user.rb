FactoryBot.define do
  factory :user1, class: User do
    name { 'user1' }
    email { 'user1@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end

  factory :user2, class: User do
    name { 'user2' }
    email { 'user2@email.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
  end

  factory :admin_user, class: User do
    name { 'admin' }
    email { 'admin@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end
end