FactoryBot.define do
  factory :comment do
    user { nil }
    review { nil }
    content { 'test' }
  end
end