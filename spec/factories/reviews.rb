FactoryBot.define do
  factory :review do
    title { 'test_title' }
    problem { 'test_problem' }
    detail { 'test_detail' }
    solution { 'test_solution' }
    content { 'test_content' }
  end

  factory :second_review, class: Review do
    title {'test_title2' }
    problem { 'test_proble2' }
    detail { 'test_problem2' }
    solution { 'test_solution2' }
    content { 'test_content2' }
  end
end