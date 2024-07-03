FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Job.field + ": " + Faker::Lorem.paragraph(sentence_count: 2) }
    start_date { Faker::Date.forward(days: 30) }
    end_date { Faker::Date.forward(days: 180) }
    status { "active" }
    skills { "#{Faker::ProgrammingLanguage.name}, #{Faker::ProgrammingLanguage.name}" }
    association :recruiter
  end
end
