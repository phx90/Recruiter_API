class PublicJobShowService
  def initialize(job_id)
    @job_id = job_id
  end

  def call
    Job.find(@job_id)
  rescue ActiveRecord::RecordNotFound => e
    { error: e.message }
  end
end
