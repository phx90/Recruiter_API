FactoryBot.define do
    factory :submission do
      name { "Jane Doe" }
      email { "jane@example.com" }
      mobile_phone { "1234567890" }
      resume { "Link to resume or resume content" }
      association :job
    end
  end
  