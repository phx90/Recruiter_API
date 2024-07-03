FactoryBot.define do
  factory :submission do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    mobile_phone { Faker::PhoneNumber.cell_phone_in_e164 }
    resume { Faker::Lorem.paragraphs(number: 3).join("\n") }
    association :job
  end
end