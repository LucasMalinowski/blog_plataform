FactoryBot.define do
  factory :comment do
    body { "Comment Body" }
    association :user
    association :post
  end
end
