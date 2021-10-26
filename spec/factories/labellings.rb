FactoryBot.define do
  factory :labelling do
    association :label
    association :review
  end
end