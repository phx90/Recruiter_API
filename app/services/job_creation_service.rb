class JobCreationService
    def initialize(recruiter, job_params)
      @recruiter = recruiter
      @job_params = job_params
    end
  
    def call
      job = @recruiter.jobs.build(@job_params)
      save_job(job)
    end
  
    private
  
    def save_job(job)
      return success_response(job) if job.save
  
      error_response(job.errors)
    end
  
    def success_response(job)
      { job: job, status: :created }
    end
  
    def error_response(errors)
      { errors: errors, status: :unprocessable_entity }
    end
  end
  