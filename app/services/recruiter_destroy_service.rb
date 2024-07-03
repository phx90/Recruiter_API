class RecruiterDestroyService
    def initialize(recruiter)
      @recruiter = recruiter
    end
  
    def call
      @recruiter.destroy!
    rescue ActiveRecord::RecordNotFound
      raise RecruiterNotFoundError, "Recruiter with ID #{@recruiter.id} not found"
    end
  end
  