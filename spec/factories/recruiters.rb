FactoryBot.define do
  factory :recruiter do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
  end
end