class RecruiterCreateService
    def initialize(params)
      @params = params
    end
  
    def call
      recruiter = Recruiter.new(@params)
      raise InvalidRecruiterError.new(recruiter.errors) unless recruiter.save
  
      recruiter
    end
  end
  