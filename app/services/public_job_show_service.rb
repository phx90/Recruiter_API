class PublicJobShowService
    def initialize(job_id)
      @job_id = job_id
    end
  
    def call
      job = Job.find(@job_id)
      {
        id: job.id,
        title: job.title,
        description: job.description,
        start_date: job.start_date,
        end_date: job.end_date,
        status: job.status,
        skills: job.skills,
        created_at: job.created_at,
        updated_at: job.updated_at
      }
    rescue ActiveRecord::RecordNotFound => e
      { error: e.message }
    end
  end
  