class RecruiterShowService
    def initialize(recruiter_id)
      @recruiter_id = recruiter_id
    end
  
    def call
      recruiter = Recruiter.find_by(id: @recruiter_id)
      raise RecruiterNotFoundError, "Recruiter with ID #{@recruiter_id} not found" unless recruiter
  
      recruiter
    end
  end
  