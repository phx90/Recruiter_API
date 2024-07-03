class JobUpdateService
    def initialize(job, job_params)
      @job = job
      @job_params = job_params
    end
  
    def call
      @job.assign_attributes(@job_params)
      save_job(@job)
    end
  
    private
  
    def save_job(job)
      return success_response(job) if job.save
  
      error_response(job.errors)
    end
  
    def success_response(job)
      { job: job, status: :ok }
    end
  
    def error_response(errors)
      { errors: errors, status: :unprocessable_entity }
    end
  end
  