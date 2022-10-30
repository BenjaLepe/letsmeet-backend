FactoryBot.define do
  factory :random_events, class: Event do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    price { Faker::Number.number(digits: 5) }
    start_date { DateTime.now }
    end_date { DateTime.now }
    author_id { FactoryBot.create(:user).id }
  end

  factory :user, class: User do
    email { Faker::Internet.email }
    password { 'password' }
  end
end
