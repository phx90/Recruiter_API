module RequestSpecHelper
    def json
      JSON.parse(response.body)
    end
  
    def token_generator(recruiter_id)
      secret = Rails.application.secrets.secret_key_base
      JWT.encode({ recruiter_id: recruiter_id }, secret)
    end
  
    def expired_token_generator(recruiter_id)
      secret = Rails.application.secrets.secret_key_base
      JWT.encode({ recruiter_id: recruiter_id, exp: Time.now.to_i - 10 }, secret)
    end
  
    def valid_headers
      recruiter = Recruiter.find_or_create_by(email: 'test@example.com') do |r|
        r.name = 'Test User'
        r.password = 'password123'
      end
      {
        "Authorization" => token_generator(recruiter.id),
        "Content-Type" => "application/json"
      }
    end
  
    def invalid_headers
      {
        "Authorization" => nil,
        "Content-Type" => "application/json"
      }
    end
  end
  