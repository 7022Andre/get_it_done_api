FactoryGirl.define do
  factory :list do
    title Faker::Beer.name
    public true
  end
end
