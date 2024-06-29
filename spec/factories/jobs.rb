FactoryBot.define do
    factory :job do
      title { "Software Engineer" }
      description { "Develop and maintain software applications." }
      start_date { "2024-07-01" }
      end_date { "2024-12-31" }
      status { "active" }
      skills { "Ruby, Rails, JavaScript" }
      association :recruiter
    end
  end
  