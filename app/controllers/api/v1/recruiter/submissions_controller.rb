module Api
  module V1
    module Recruiter
      class SubmissionsController < ApplicationController
        before_action :authorize_request
        before_action :set_submission, only: %i[show update destroy]
        before_action :set_job, only: %i[index create]

        def index
          render json: @job.submissions
        end

        def show
          render json: @submission
        end

        def create
          @submission = Submission.new(submission_params)
          if @submission.save
            render json: @submission, status: :created
          else
            render json: @submission.errors, status: :unprocessable_entity
          end
        end

        def update
          if @submission.update(submission_params)
            render json: @submission
          else
            render json: @submission.errors, status: :unprocessable_entity
          end
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
      end
    end
  end
end
