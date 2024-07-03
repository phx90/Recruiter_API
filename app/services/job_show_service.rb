class JobShowService
    def initialize(recruiter, job_id)
      @recruiter = recruiter
      @job_id = job_id
    end
  
    def call
      @recruiter.jobs.find(@job_id)
    end
  end
  