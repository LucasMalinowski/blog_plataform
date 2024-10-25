FactoryBot.define do
  factory :post do
    title { "Post Title" }
    body { "Post Body" }
    association :user
  end
end
