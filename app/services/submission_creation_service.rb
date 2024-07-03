# app/services/submission_creation_service.rb
class SubmissionCreationService
    def initialize(job, submission_params)
      @job = job
      @submission_params = submission_params
    end
  
    def call
      submission = @job.submissions.build(@submission_params)
      return success_response(submission) if submission.validate_uniqueness && submission.save
  
      error_response(submission.errors)
    end
  
    private
  
    def success_response(submission)
      { submission: submission, status: :created }
    end
  
    def error_response(errors)
      { errors: errors, status: :unprocessable_entity }
    end
  end
  