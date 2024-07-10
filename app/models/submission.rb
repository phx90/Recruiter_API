class Submission < ApplicationRecord
  searchkick
  belongs_to :job

  validates :name, :email, :mobile_phone, :resume, :job_id, presence: true
  validates :email, uniqueness: { scope: :job_id, message: 'You have already applied for this job' }

  def self.create_submission(job, submission_params)
    submission = job.submissions.build(submission_params)
    return submission.save_submission if submission.validate_uniqueness

    submission.errors_submission
  end

  def validate_uniqueness
    !already_applied?
  end

  def save_submission
    save
    { submission: self, status: :created }
  end

  def errors_submission
    { errors: errors, status: :unprocessable_entity }
  end

  def already_applied?
    self.class.already_applied(job.id, email)
  end

  private

  def self.already_applied(job_id, email)
    where(job_id: job_id, email: email).exists?
  end
end
