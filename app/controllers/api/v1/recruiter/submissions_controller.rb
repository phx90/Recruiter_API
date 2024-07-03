module Api
  module V1
    module Recruiter
      class SubmissionsController < ApplicationController
        before_action :authorize_request
        before_action :set_job, only: %i[index create]
        before_action :set_submission, only: %i[show update destroy]

        def index
          @submissions = @job.submissions
          @submissions = @submissions.by_status(params[:status]) if params[:status].present?
          render :index
        end

        def show
          render :show
        end

        def create
          result = SubmissionCreationService.new(@job, submission_params).call
          render_response(result)
        end

        def update
          @submission.update(submission_params)
          render_response(update_response(@submission))
        end

        def destroy
          @submission.destroy
          head :no_content
        end

        private

        def set_submission
          @submission = Submission.find_by(id: params[:id], job_id: params[:job_id])
          render json: { error: 'Submission not found' }, status: :not_found unless @submission
        end

        def set_job
          @job = @current_recruiter.jobs.find(params[:job_id])
        end

        def submission_params
          params.require(:submission).permit(:name, :email, :mobile_phone, :resume, :job_id)
        end

        def render_response(result)
          render json: result[:errors] || result[:submission], status: result[:status]
        end

        def update_response(submission)
          return { submission: submission, status: :ok } unless submission.errors.any?

          { errors: submission.errors, status: :unprocessable_entity }
        end
      end
    end
  end
end
