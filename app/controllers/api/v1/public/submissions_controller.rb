module Api
    module V1
      module Public
        class SubmissionsController < ApplicationController
  
          def create
            @job = Job.find(params[:job_id])
            @submission = @job.submissions.build(submission_params)
            if Submission.exists?(job_id: @job.id, email: @submission.email)
              render json: { error: 'You have already applied for this job' }, status: :unprocessable_entity
            elsif @submission.save
              render json: @submission, status: :created
            else
              render json: @submission.errors, status: :unprocessable_entity
            end
          end
  
          private
  
          def submission_params
            params.require(:submission).permit(:name, :email, :mobile_phone, :resume)
          end
        end
      end
    end
  end
  