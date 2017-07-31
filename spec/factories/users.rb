FactoryGirl.define do
  pw = Faker::Internet.password(8)
  factory :user do
    sequence(:email) { |n| "user#{n}@getitdoneapi.abc" }
    password pw
    password_confirmation pw
  end
end
