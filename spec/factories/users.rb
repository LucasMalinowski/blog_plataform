FactoryBot.define do
  factory :user do
    email { "test@email.com"}
    password { "password" }
    name { "Test User" }

    after(:create) do |user|
      user.confirm
    end
  end
end
